//
//  StartViewController.swift
//  Jumper
//
//  Created by USER on 17/09/2018.
//  Copyright © 2018 LearnAppMaking. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var CountDown: UILabel!
    var countDown = 5
    var startTimer = Timer()
    var valueMessage = "Click Begin to start"

    override func viewDidLoad() {

        super.viewDidLoad()
        countDown = 3
        valueMessage = "Click Begin to start"
        CountDown.text = valueMessage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func startTimer() {
        countDown -= 1
        switch countDown {
        case 3:
            valueMessage = "Click Begin to start"
        case 2:
            valueMessage = "Ready"
        case 1:
            valueMessage = "Set"
        case 0:
            valueMessage = "Go"
            startTimer.invalidate()
            timeRemaining = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StartViewController.playGameTimer), userInfo: nil, repeats: true)
        default:
            valueMessage = "Click Begin to start"
        }
        CountDown.text = valueMessage
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
