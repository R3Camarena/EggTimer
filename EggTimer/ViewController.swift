//
//  ViewController.swift
//  EggTimer
//
//  Created by Ricardo Camarena on 12/07/2022.
//  Copyright © 2022 Ricardo Camarena. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720] // Seconds that each type of eggs takes to be made
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer? // For the sound
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!

        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate() // Set timer to 0
        titleLabel.text = sender.currentTitle!
        progressBar.progress = 0.0 // Set Progress Bar to 0
        secondsPassed = 0 // Set seconds passed to 0
        
        let hardness = sender.currentTitle! // Soft, Medium or Hard
        totalTime = eggTimes[hardness]! // Assign the eggTime times to the seconds remaining in the counter
                
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondsPassed < totalTime {
                secondsPassed += 1 // Adds one to seconds passed to calculate Progress Barr progress
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
                } else {
                    Timer.invalidate()
                    titleLabel.text = "Done!" // Changes Label to "Done!"
                    playSound() // Plays sound
                }
            }
        
    }
    
}
