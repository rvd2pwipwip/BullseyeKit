//
//  ViewController.swift
//  BullseyeKit
//
//  Created by Herve Desrosiers on 2019-11-17.
//  Copyright © 2019 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var targetValue = 0
    var currentValue = 0
    var round = 0
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
        
        // custom slider skin:
        
//        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //with Image Literal
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
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

