//
//  ViewController.swift
//  Bulls_Eye_Second_Edition
//
//  Created by Timofey Privalov on 02/04/2018.
//  Copyright © 2018 Timofey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 50
    var targerValue: Int = 0
    var score = 0
    var round = 1
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startOver()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImagaHighlated = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImagaHighlated, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftImage, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightImage, for: .normal)
        
    }
    
    func updateLabel() {
        target.text = String(targerValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    

    func startNewRound() {
        targerValue = Int(arc4random_uniform(100)) + 1
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabel()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    @IBAction func sliderMoving(_ slider: UISlider) {
        print("Value of slider is: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    
    @IBAction func showAlert() {
        let difference: Int = abs(targerValue - currentValue)
        
        let points: Int = 100 - difference
        if difference != 0 {
            score += points
        } else {
            score += (points)*2
        }
        
        round += 1
        
        let title: String
        if difference == 0 {
            title = "That is great result"
        } else if difference <= 10 {
            title = "Awesome result"
        } else {
            title = "You better try again!"
        }
        
        let message = "You points is: \(points)"
        
        let alert = UIAlertController(title: "Welcome to round: \(round)\n" +
            "the target value is: \(targerValue)\n" +
            "difference is: \(difference)\n" +
            "\(title)", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Let's try!", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func startOver() {
        score = 0
        round = 1
        startNewRound()
    }


}

