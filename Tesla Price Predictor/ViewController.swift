//
//  ViewController.swift
//  Tesla Price Predictor
//
//  Created by Somesh Arora on 5/20/19.
//  Copyright © 2019 Somesh Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cars = Cars()

    @IBOutlet weak var modelSegmentControl: UISegmentedControl!
    @IBOutlet weak var upgradesSegmentControl: UISegmentedControl!
    @IBOutlet weak var mileageSlider: UISlider!
    @IBOutlet weak var conditionSegmentControl: UISegmentedControl!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateValue(self)
    }
    @IBAction func calculateValue(_ sender: Any) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileageSlider.value) ?? "0"
        mileageLabel.text = "Mileage: (\(formattedMileage) miles)"
        
        if let prediction = try? cars.prediction(model: Double(modelSegmentControl.selectedSegmentIndex),
                                                 premium: Double(upgradesSegmentControl.selectedSegmentIndex),
                                                 mileage: Double(mileageSlider.value),
                                                 condition: Double(conditionSegmentControl.selectedSegmentIndex)) {
            let clampValuation = max(5000, prediction.price)
            formatter.numberStyle = .currency
            valueLabel.text = formatter.string(for: clampValuation)
        } else {
            valueLabel.text = "--"
        }
        
    }
}

