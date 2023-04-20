//
//  StopWatchViewController.swift
//  timer
//
//  Created by Student on 4/12/23.
//

import UIKit

class StopWatchViewController: UIViewController, UITableViewDataSource {
    
    var timer = Timer()
    var countdownSeconds = 20
    var minuteCounter = 0
    var secondCounter = 0
    var centisecondCounter = 0
    var isPaused = false
    var tableString = ["hi"]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var stopwatchLabelUI: UILabel!
    
    @IBOutlet var minuteLabel: UILabel!
    
    @IBOutlet var secondLabel: UILabel!
    
    @IBOutlet var centisecondLabel: UILabel!
    
    @IBOutlet weak var lapButtonUI: UIButton!
    
    @IBOutlet var playButtonUI: UIButton!
    
    @IBOutlet weak var pauseButtonUI: UIButton!
    
    @IBOutlet var stopButtonUI: UIButton!
    
    @IBAction func onPlayPressed(_ sender: Any) {
        stopwatchLabelUI.text = "StopWatch"
        if playButtonUI.backgroundColor == UIColor.green && centisecondCounter == 0 {
            playButtonUI.backgroundColor = UIColor.gray
            playButtonUI.isEnabled = false
            centisecondCounter = 0
            secondCounter = 0
            minuteCounter = 0
            centisecondLabel.text = ":\(centisecondCounter)"
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {  [unowned self] timer in
                centisecondCounter += 1
                if centisecondCounter == 100 {
                    centisecondCounter -= 100
                    secondCounter += 1
                    if secondCounter < 10 {
                        secondLabel.text = ":0\(secondCounter)"
                    } else {
                        secondLabel.text = ":\(secondCounter)"
                    }
                    if secondCounter == 60 {
                        secondCounter -= 60
                        minuteCounter += 1
                        if minuteCounter < 10 {
                            minuteLabel.text = "0\(minuteCounter)"
                        } else {
                            minuteLabel.text = "\(minuteCounter)"
                        }
                    }
                } else if centisecondCounter < 10 {
                    centisecondLabel.text = ":0\(String(describing: centisecondCounter))"
                } else {
                    centisecondLabel.text = ":\(String(describing: centisecondCounter))"
                }
            }
        }
    }
    
    
    @IBAction func onPauseButtonPressed(_ sender: Any) {
        if isPaused == false && centisecondCounter > 0 && playButtonUI.isEnabled == false {
            timer.invalidate()
            isPaused = true
            playButtonUI.isEnabled = false
            pauseButtonUI.setTitle("Resume", for: .normal)
            pauseButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
        } else if isPaused == true && playButtonUI.isEnabled == false {
            self.isPaused = false
            playButtonUI.isEnabled = false
            pauseButtonUI.setTitle("Pause", for: .normal)
            pauseButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
            timer.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {  [unowned self] timer in
                self.centisecondCounter += 1
                if self.centisecondCounter == 100 {
                    centisecondCounter -= 100
                    secondCounter += 1
                    if secondCounter < 10 {
                        secondLabel.text = ":0\(secondCounter)"
                    } else {
                        secondLabel.text = ":\(secondCounter)"
                    }
                    if secondCounter == 60 {
                        secondCounter -= 60
                        minuteCounter += 1
                        if minuteCounter < 10 {
                            minuteLabel.text = "0\(minuteCounter)"
                        } else {
                            minuteLabel.text = "\(minuteCounter)"
                        }
                    }
                } else if centisecondCounter < 10 {
                    self.centisecondLabel.text = ":0\(String(describing: self.centisecondCounter))"
                } else {
                    self.centisecondLabel.text = ":\(String(describing: self.centisecondCounter))"
                }
            }
        }
    }
    
    
    
    @IBAction func onStopButtonPressed(_ sender: Any) {
        if playButtonUI.backgroundColor == UIColor.gray && playButtonUI.isEnabled == false {
            playButtonUI.backgroundColor = UIColor.green
            playButtonUI.isEnabled = true
            timer.invalidate()
            centisecondCounter = 0
            secondCounter = 0
            minuteCounter = 0
            centisecondLabel.text = ":00"
            secondLabel.text = ":00"
            minuteLabel.text = "00"
            pauseButtonUI.setTitle("Pause", for: .normal)
            pauseButtonUI.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
        }
    }
    
    
    @IBAction func onLapButtonPressed(_ sender: Any) {
        if centisecondCounter < 10 && secondCounter < 10 {
            tableString = tableString + ["\(minuteCounter):0\(secondCounter):0\(centisecondCounter)"]
            tableView.reloadData()
        } else if centisecondCounter < 10 {
            tableString = tableString + ["\(minuteCounter):\(secondCounter):0\(centisecondCounter)"]
            tableView.reloadData()
        } else if secondCounter < 10 {
            tableString = tableString + ["\(minuteCounter):0\(secondCounter):\(centisecondCounter)"]
            tableView.reloadData()
        } else {
            tableString = tableString + ["\(minuteCounter):\(secondCounter):\(centisecondCounter)"]
            tableView.reloadData()
        }
    }
    
    @IBAction func onClearButtonPressed(_ sender: Any) {
        tableString = ["0:00:00"]
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButtonUI.backgroundColor = UIColor.green
        pauseButtonUI.backgroundColor = UIColor.orange
        stopButtonUI.backgroundColor = UIColor.red
        
        tableString = ["\(minuteCounter):\(secondCounter):\(centisecondCounter)"]
        
        tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableString.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableString[indexPath.row]
        
        return cell
    }
}


