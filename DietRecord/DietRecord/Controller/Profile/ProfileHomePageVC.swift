//
//  ProfileHomePageVC.swift
//  DietRecord
//
//  Created by chun on 2022/11/12.
//

import UIKit

class ProfileHomePageVC: UIViewController, UITableViewDataSource {
    @IBOutlet weak var homeTableView: UITableView!
    
    var followingPosts: [MealRecord] = [] {
        didSet {
            homeTableView.reloadData()
        }
    }
    let profileProvider = ProfileProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.registerCellWithNib(identifier: ProfileDetailCell.reuseIdentifier, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFollowingPost()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func fetchFollowingPost() {
        LKProgressHUD.show()
        profileProvider.fetchFollowingPost { result in
            switch result {
            case .success(let mealRecords):
                LKProgressHUD.dismiss()
                self.followingPosts = mealRecords.sorted { $0.createdTime > $1.createdTime }.filter { $0.isShared }
            case .failure(let error):
                print("Error Info: \(error).")
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        followingPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileDetailCell.reuseIdentifier, for: indexPath) as? ProfileDetailCell
        else { fatalError("Could not create the profile detail cell.") }
        let mealRecord = self.followingPosts[indexPath.row]
        cell.haveResponses = false
        cell.controller = self
        cell.layoutCell(mealRecord: mealRecord)
        return cell
    }
}
