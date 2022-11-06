//
//  ReportDetailCell.swift
//  DietRecord
//
//  Created by chun on 2022/11/2.
//

import UIKit

class ReportDetailCell: UITableViewCell {
    @IBOutlet weak var caloriesCurrentLabel: UILabel!
    @IBOutlet weak var carbsCurrentLabel: UILabel!
    @IBOutlet weak var fiberCurrentLabel: UILabel!
    @IBOutlet weak var sugarCurrentLabel: UILabel!
    @IBOutlet weak var proteinCurrentLabel: UILabel!
    @IBOutlet weak var fatCurrentLabel: UILabel!
    @IBOutlet weak var saturatedFatCurrentLabel: UILabel!
    @IBOutlet weak var monounsaturatedFatCurrentLabel: UILabel!
    @IBOutlet weak var polyunsaturatedFatCurrentLabel: UILabel!
    @IBOutlet weak var cholesterolCurrentLabel: UILabel!
    @IBOutlet weak var sodiumCurrentLabel: UILabel!
    @IBOutlet weak var potassiumCurrentLabel: UILabel!
    
    
    @IBOutlet weak var caloriesGoalLabel: UILabel!
    @IBOutlet weak var carbsGoalLabel: UILabel!
    @IBOutlet weak var fiberGoalLabel: UILabel!
    @IBOutlet weak var sugarGoalLabel: UILabel!
    @IBOutlet weak var proteinGoalLabel: UILabel!
    @IBOutlet weak var fatGoalLabel: UILabel!
    @IBOutlet weak var saturatedFatGoalLabel: UILabel!
    @IBOutlet weak var monounsaturatedFatGoalLabel: UILabel!
    @IBOutlet weak var polyunsaturatedFatGoalLabel: UILabel!
    @IBOutlet weak var cholesterolGoalLabel: UILabel!
    @IBOutlet weak var sodiumGoalLabel: UILabel!
    @IBOutlet weak var potassiumGoalLabel: UILabel!
    
    func layoutCell(foodDailyInputs: [FoodDailyInput]?) {
        guard let foodDailyInputs = foodDailyInputs else { return }
        let totalFoods = foodDailyInputs.flatMap { $0.mealRecord }.flatMap { $0.foods }
        self.caloriesCurrentLabel.text = calculateMacroNutrition(foods: totalFoods, nutrient: .calories).format()
        self.carbsCurrentLabel.text = calculateMacroNutrition(foods: totalFoods, nutrient: .carbohydrate).format()
        self.fiberCurrentLabel.text = calculateMacroNutrition(foods: totalFoods, nutrient: .dietaryFiber).format()
        self.sugarCurrentLabel.text = calculateMacroNutrition(foods: totalFoods, nutrient: .sugar).format()
        self.proteinCurrentLabel.text = calculateMacroNutrition(foods: totalFoods, nutrient: .protein).format()
        self.fatCurrentLabel.text = calculateMacroNutrition(foods: totalFoods, nutrient: .lipid).format()
        self.saturatedFatCurrentLabel.text = calculateMicroNutrition(
            foods: totalFoods, nutrient: .saturatedLipid).format()
        self.monounsaturatedFatCurrentLabel.text = (calculateMicroNutrition(
            foods: totalFoods, nutrient: .monounsaturatedLipid) / 1000).format()
        self.polyunsaturatedFatCurrentLabel.text = (calculateMicroNutrition(
            foods: totalFoods, nutrient: .polyunsaturatedLipid) / 1000).format()
        self.cholesterolCurrentLabel.text = (calculateMicroNutrition(
            foods: totalFoods, nutrient: .cholesterol) / 1000).format()
        self.sodiumCurrentLabel.text = (calculateMicroNutrition(
            foods: totalFoods, nutrient: .sodium) / 1000).format()
        self.potassiumCurrentLabel.text = (calculateMicroNutrition(
            foods: totalFoods, nutrient: .potassium) / 1000).format()
    }
    
    func layoutOfGoal(goal: NutrientContent) {
        self.caloriesGoalLabel.text = (goal.calories.transformToDouble() * 7).format()
        self.carbsGoalLabel.text = (goal.carbohydrate.transformToDouble() * 7).format()
        self.fiberGoalLabel.text = (goal.dietaryFiber.transformToDouble() * 7).format()
        self.sugarGoalLabel.text = (goal.sugar.transformToDouble() * 7).format()
        self.proteinGoalLabel.text = (goal.protein.transformToDouble() * 7).format()
        self.fatGoalLabel.text = (goal.lipid.transformToDouble() * 7).format()
        self.saturatedFatGoalLabel.text = (goal.lipid.transformToDouble() * 7).format()
        self.monounsaturatedFatGoalLabel.text = (goal.monounsaturatedLipid.transformToDouble() * 7 / 1000).format()
        self.polyunsaturatedFatGoalLabel.text = (goal.polyunsaturatedLipid.transformToDouble() * 7 / 1000).format()
        self.cholesterolGoalLabel.text = (goal.cholesterol.transformToDouble() * 7 / 1000).format()
        self.sodiumGoalLabel.text = (goal.sodium.transformToDouble() * 7 / 1000).format()
        self.potassiumGoalLabel.text = (goal.potassium.transformToDouble() * 7 / 1000).format()
    }
}