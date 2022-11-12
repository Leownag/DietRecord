//
//  GoalVC.swift
//  DietRecord
//
//  Created by chun on 2022/11/9.
//

import UIKit

class GoalVC: UIViewController {
    @IBOutlet weak var whiteBackgroundView: UIView!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var automaticButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whiteBackgroundView.layer.cornerRadius = 20
        inputButton.addTarget(self, action: #selector(goToSetupGoalVC), for: .touchUpInside)
        automaticButton.addTarget(self, action: #selector(goToSetupGoalVC), for: .touchUpInside)
        self.tabBarController?.tabBar.isHidden = true
        caloriesLabel.text = userData?.goal[0].transform(unit: kcalUnit)
        carbsLabel.text = userData?.goal[1].transform(unit: gUnit)
        proteinLabel.text = userData?.goal[2].transform(unit: gUnit)
        fatLabel.text = userData?.goal[3].transform(unit: gUnit)
        whiteBackgroundView.setShadowAndRadius(radius: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func goToSetupGoalVC(sender: UIButton) {
        let storyboard = UIStoryboard(name: report, bundle: nil)
        if let setupGoalPage = storyboard.instantiateViewController(withIdentifier: "\(SetupGoalVC.self)")
            as? SetupGoalVC {
            if sender == inputButton {
                setupGoalPage.isAutomatic = false
            }
            setupGoalPage.closure = { [weak self] goal in
                self?.caloriesLabel.text = goal[0].transform(unit: kcalUnit)
                self?.carbsLabel.text = goal[1].transform(unit: gUnit)
                self?.proteinLabel.text = goal[2].transform(unit: gUnit)
                self?.fatLabel.text = goal[3].transform(unit: gUnit)
            }
            self.navigationController?.pushViewController(setupGoalPage, animated: false)
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}
