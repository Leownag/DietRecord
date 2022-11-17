//
//  ProfileInformationVC.swift
//  DietRecord
//
//  Created by chun on 2022/11/15.
//

import UIKit

class ProfileInformationVC: UIViewController, UITableViewDataSource {
    @IBOutlet weak var profileInfoTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var goBackButton: UIButton!
    
    var isUpdated = false
    var user: User?
    let profileProvider = ProfileProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileInfoTableView.dataSource = self
        saveButton.addTarget(self, action: #selector(createUserInfo), for: .touchUpInside)
        if !isUpdated {
            goBackButton.isHidden = true
        } else {
            self.user = userData
            goBackButton.isHidden = false
            goBackButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func createUserInfo() {
        LKProgressHUD.show()
        guard let user = user else { return }
        if user.username.isEmpty || user.weightGoal.isEmpty || user.waterGoal.isEmpty || user.goal.isEmpty {
            LKProgressHUD.dismiss()
            self.presentInputAlert(title: "請輸入完整資料")
        } else {
            profileProvider.createUserInfo(userData: user) { result in
                switch result {
                case .success:
                    userData = user
                    LKProgressHUD.showSuccess()
                    if !self.isUpdated {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        if let tabbarController = storyboard.instantiateViewController(
                            withIdentifier: "\(TabBarController.self)")
                            as? TabBarController {
                            self.navigationController?.pushViewController(tabbarController, animated: false)
                        }
                    } else {
                        self.navigationController?.popViewController(animated: false)
                    }
                case .failure(let error):
                    LKProgressHUD.showFailure(text: "儲存資料失敗")
                    print("Error Info: \(error).")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileInformationCell.reuseIdentifier, for: indexPath) as? ProfileInformationCell
        else { fatalError("Could not create the profile information cell.") }
        if isUpdated {
            guard let userData = userData else { fatalError("Could not find user data.") }
            cell.user = userData
            cell.goal = userData.goal
        }
        cell.controller = self
        cell.layoutCell()
        return cell
    }
}