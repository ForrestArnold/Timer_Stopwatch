//
//  ViewController.swift
//  timer
//
//  Created by Student on 4/11/23.
//

import UIKit
import AVFoundation

class TimerHomeScreenViewController: UIViewController {
    
    var timerParamaters = MyClock(minTime: 1, maxTime: 50, startingTime: 100)
    var countdownTimer: Timer?
    var countdownSeconds = 0
    var isPaused = false
    var timer = Timer()
    var player: AVAudioPlayer!
    
    
    @IBAction func onStopWatchPressed(_ sender: Any) {
        guard let stopVC = storyboard?.instantiateViewController(withIdentifier: "stop_vc") as? StopWatchViewController else {
            return
        }
        present(stopVC, animated: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "oh_my_god_vine", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player!.play()
    }
    

    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    @IBOutlet var minLabelUI: UITextField!
    
    @IBAction func minTextFieldChanged(_ sender: UITextField) {
    }
    
    @IBOutlet var maxLabelUI: UITextField!
    
    @IBAction func maxTextFieldChanged(_ sender: UITextField) {
    }
    
    @IBOutlet var timerInputSwitchUI: UISwitch!
    
    @IBOutlet var setTimerToUI: UITextField!
    
    @IBAction func onSetTimerPressed(_ sender: Any) {
    }
    
    
    @IBOutlet var showTimerUI: UIButton!
    
    @IBAction func onPressShowTimer(_ sender: Any) {
        if countdownLabelUI.isHidden == true {
            showTimerUI.setTitle("Hide Timer", for: .normal)
            countdownLabelUI.isHidden = false
        } else {
            showTimerUI.setTitle("Show Timer", for: .normal)
            countdownLabelUI.isHidden = true
        }
    }
    
    @IBAction func onTimerInputSwitchToggled(_ sender: Any) {
        if timerInputSwitchUI.isOn == false {
            randomOrSetRangeLabel.text = "Choose a time"
            minLabelUI.isHidden = true
            maxLabelUI.isHidden = true
            setTimerToUI.isHidden = false
        } else {
            randomOrSetRangeLabel.text = "Random time in range"
            minLabelUI.isHidden = false
            maxLabelUI.isHidden = false
            setTimerToUI.isHidden = true
        }
    }
    
    @IBOutlet var randomOrSetRangeLabel: UILabel!
    
    @IBOutlet var countdownLabelUI: UILabel!
    
    @IBOutlet var playButtonUI: UIButton!
    
    @IBAction func onPlayButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        if timerInputSwitchUI.isOn == true && playButtonUI.backgroundColor == UIColor.white && minLabelUI.text != "" && maxLabelUI.text != "" {
            playButtonUI.isHighlighted = true
            playButtonUI.setTitle("Playing", for: .normal)
            playButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
            playButtonUI.backgroundColor = UIColor.green
            if minLabelUI.text != nil && maxLabelUI.text != nil {
                guard let minValue = Int(minLabelUI.text ?? ""),
                      let maxValue = Int(maxLabelUI.text ?? "") else {
                    return
                }
                let min = minValue < maxValue ? minValue : maxValue
                let max = minValue < maxValue ? maxValue : minValue
                let trueRandomNumber = Int.random(in: min...max)
                countdownLabelUI.text = "\(trueRandomNumber)"
                countdownSeconds = trueRandomNumber
                countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in guard let self = self else {
                    return
                }
                    self.countdownSeconds -= 1
                    if self.countdownSeconds == 0 {
                        self.countdownLabelUI.text = "Done!"
                        self.playSound()
                        timer.invalidate()
                        self.playButtonUI.backgroundColor = UIColor.white
                        self.playButtonUI.setTitle("Play", for: .normal)
                        self.playButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
                    } else {
                        self.countdownLabelUI.text = "\(self.countdownSeconds)"
                    }
                }
            }
        } else if timerInputSwitchUI.isOn == false && playButtonUI.backgroundColor == UIColor.white && setTimerToUI.text != "" {
            playButtonUI.backgroundColor = UIColor.green
            if setTimerToUI.text != nil {
                guard let timerUI = Int(setTimerToUI.text ?? "")
                else {
                    return
                }
                countdownSeconds = timerUI
                countdownLabelUI.text = "\(String(describing: setTimerToUI))"
                countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in guard let self = self else {
                    return
                }
                    self.countdownSeconds -= 1
                    if self.countdownSeconds == 0 {
                        self.countdownLabelUI.text = "Done!"
                        timer.invalidate()
                        self.playSound()
                        self.playButtonUI.backgroundColor = UIColor.white
                        self.playButtonUI.setTitle("Play", for: .normal)
                        self.playButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
                    } else {
                        self.countdownLabelUI.text = "\(self.countdownSeconds)"
                    }
                }
            }
        }
    }
    
    @IBOutlet var pauseButtonUI: UIButton!
    
    @IBAction func onPauseButtonPressed(_ sender: Any) {
        if isPaused == false && playButtonUI.backgroundColor == UIColor.green && countdownSeconds > 0 {
            countdownTimer?.invalidate()
            isPaused = true
            pauseButtonUI.setTitle("Resume", for: .normal)
            pauseButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
        } else if playButtonUI.backgroundColor == UIColor.green {
            pauseButtonUI.setTitle("Pause", for: .normal)
            pauseButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
            countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in guard let self = self else {
                return
            }
                self.countdownSeconds -= 1
                if self.countdownSeconds == 0 {
                    self.countdownLabelUI.text = "Timer Done!!"
                    timer.invalidate()
                } else {
                    self.countdownLabelUI.text = "\(self.countdownSeconds)"
                }
            }
            isPaused = false
        }
    }
        
    
    @IBOutlet var stopButtonUI: UIButton!
    
    @IBAction func onStopButtonPressed(_ sender: Any) {
        if playButtonUI.backgroundColor == UIColor.green && pauseButtonUI.backgroundColor == UIColor.orange {
            playButtonUI.backgroundColor = UIColor.white
            countdownTimer?.invalidate()
            timer.invalidate()
            countdownSeconds = 0
            countdownLabelUI.text = "0"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownLabelUI.isHidden = false
        playButtonUI.backgroundColor = UIColor.white
        pauseButtonUI.backgroundColor = UIColor.orange
    }
}

