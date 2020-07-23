//
//  ViewController.swift
//  CircularProgressView
//
//  Created by Nitin on 20/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView: CircularView!
    var timer : Timer!
    var percentage : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView.makeCircularPath()
        
    }

    @IBAction func reverse(_ sender: Any) {
        if (timer != nil ){timer.invalidate()}
        self.progressView.setProgressWithAnimation(duration: 0, toValue: Float(100/100), fromValue: Float(0))
        percentage = 100
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
            let from = self.percentage
            self.percentage = (self.percentage - 1.0)
            
            print(self.percentage)
            self.progressView.setProgressWithAnimation(duration: 1, toValue: Float(self.percentage/100), fromValue: Float(from / 100))
            
            if ( self.percentage == 0 ) {
                self.reset(true)
            }
                
        })
    }
    @IBAction func stop(_ sender: Any) {
        self.reset(isReset: false)
    }
    @IBAction func reset(_ sender: Any) {
        self.reset(isReset:true)
    }
    
    @IBAction func btnAction(_ sender: Any) {
       if (timer != nil ){timer.invalidate()}
        self.percentage = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
            let from = self.percentage
            self.percentage = (self.percentage + 1.0)
            
            print(self.percentage)
            self.progressView.setProgressWithAnimation(duration: 1, toValue: Float(self.percentage/100), fromValue: Float(from / 100))
            
            if ( self.percentage == 100 ) {
                self.reset(true)
            }
                
        })
    }
    
    private func reset(isReset:Bool){
        if (isReset) { self.progressView.setProgressWithAnimation(duration: 0.3, toValue: 0.0, fromValue: Float(self.percentage))
        }
        if timer == nil {
            return
        }
        self.timer.invalidate()
        self.percentage = 0.0
    }
}

