//
//  ViewController.swift
//  BullseyeKit
//
//  Created by Herve Desrosiers on 2019-11-17.
//  Copyright © 2019 Herve Desrosiers. All rights reserved.
//

// Source control test

import UIKit

class ViewController: UIViewController {
    var targetValue = 0
    var currentValue = 0
    var round = 0
    var points = 0
    var score = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        resetGame()
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!!!"
            points += 100
        } else if difference < 5 {
            title = "So close!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Good"
        } else {
            title = "Not even close..."
        }
        
        let message = "You scored \(points) points"
        score += points
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        round += 1
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = "\(targetValue)"
        roundLabel.text = "\(round)"
        scoreLabel.text = "\(score)"
    }
    
    @IBAction func resetGame() {
        round = 0
        score = 0
        startNewRound()
    }
}

