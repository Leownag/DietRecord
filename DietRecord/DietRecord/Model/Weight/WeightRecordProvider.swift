//
//  WeightRecordProvider.swift
//  DietRecord
//
//  Created by chun on 2022/11/4.
//

import Foundation

typealias WeightRecordResult = (Result<[WeightData], Error>) -> Void

class WeightRecordProvider {
    let healthManager = HealthKitManager()
    // MARK: - Update weight record from Health to firebase -
    func updateWeightRecord(weightDatas: [WeightData], completion: @escaping (Result<Void, Error>) -> Void) {
        let updateGroup = DispatchGroup()
        var blocks: [DispatchWorkItem] = []
        
        for weightData in weightDatas {
            updateGroup.enter()
            let block = DispatchWorkItem(flags: .inheritQoS) {
                let collectionReference = database.collection(user).document(userID).collection(weight)
                do {
                    let dateString = dateFormatter.string(from: weightData.date)
                    try collectionReference.document(dateString).setData(from: weightData)
                } catch {
                    completion(.failure(error))
                }
                updateGroup.leave()
            }
            blocks.append(block)
            DispatchQueue.main.async(execute: block)
        }
        updateGroup.notify(queue: DispatchQueue.main) {
            completion(.success(()))
        }
    }
    
    func fetchWeightRecord(completion: @escaping WeightRecordResult) {
        let collectionReference = database.collection(user).document(userID).collection(weight)
        collectionReference.getDocuments { snapshot, error in
            if let error = error {
                print("Error Info: \(error).")
            } else {
                var weightDatas: [WeightData] = []
                guard let snapshot = snapshot else { return }
                let documents = snapshot.documents
                for document in documents {
                    guard let weightData = try? document.data(as: WeightData.self) else { return }
                    weightDatas.append(weightData)
                }
                completion(.success(weightDatas))
            }
        }
    }
    
    func createWeightRecord(weightData: WeightData, completion: @escaping (Result<Void, Error>) -> Void) {
        let collectionReference = database.collection(user).document(userID).collection(weight)
        do {
            let dateString = dateFormatter.string(from: weightData.date)
            guard let date = dateFormatter.date(from: dateString) else { return }
            try collectionReference.document(dateString).setData(from: WeightData(date: date, value: weightData.value))
            healthManager.saveWeight(weightData: WeightData(date: date, value: weightData.value)) { result in
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteWeightRecord(weightData: WeightData, completion: @escaping (Result<Void, Error>) -> Void) {
        let collectionReference = database.collection(user).document(userID).collection(weight)
        let dateString = dateFormatter.string(from: weightData.date)
        collectionReference.document(dateString).delete()
        healthManager.deleteWeight(weightData: weightData) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}