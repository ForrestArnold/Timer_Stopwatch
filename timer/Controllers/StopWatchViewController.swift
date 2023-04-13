//
//  StopWatchViewController.swift
//  timer
//
//  Created by Student on 4/12/23.
//

import UIKit

class StopWatchViewController: UIViewController {
    
    var timer = Timer()
    var countdownSeconds = 20
    var minuteCounter = 0
    var secondCounter = 0
    var centisecondCounter = 0
    let lapTable = ["13:48", "04:02", "05:40", "01:93"]
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet var stopwatchLabelUI: UILabel!
    
    @IBOutlet var minuteLabel: UILabel!
    
    @IBOutlet var secondLabel: UILabel!
    
    @IBOutlet var centisecondLabel: UILabel!
    
    @IBOutlet var playButtonUI: UIButton!
    
    @IBOutlet var stopButtonUI: UIButton!
    
    @IBAction func onTimerButtonPressed(_ sender: Any) {
        guard let timerVC = storyboard?.instantiateViewController(withIdentifier: "timer_vc") as? TimerHomeScreenViewController else {
            return
        }
        present(timerVC, animated: true)
    }
    
    @IBAction func onPlayPressed(_ sender: Any) {
        stopwatchLabelUI.text = "StopWatch"
        if playButtonUI.backgroundColor == UIColor.green {
            self.playButtonUI.backgroundColor = UIColor.blue
            centisecondCounter = 0
            secondCounter = 0
            minuteCounter = 0
            centisecondLabel.text = ":\(centisecondCounter)"
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
    if playButtonUI.backgroundColor == UIColor.blue {
        playButtonUI.backgroundColor = UIColor.green
        timer.invalidate()
        centisecondCounter = 0
        secondCounter = 0
        minuteCounter = 0
        stopwatchLabelUI.text = "Reset"
        centisecondLabel.text = ":00"
        secondLabel.text = ":00"
        minuteLabel.text = "00"
    }
}
    
    


override func viewDidLoad() {
    super.viewDidLoad()
    
    playButtonUI.backgroundColor = UIColor.green
    stopButtonUI.backgroundColor = UIColor.red
}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapTable.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel!.text = lapTable[indexPath.row]
        return cell
    }
}


