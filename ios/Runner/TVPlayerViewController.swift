//
//  TVPlayerViewController.swift
//  Runner
//
//  Created by Mohammed Salman on 10/26/19.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//


import AVKit
import UIKit
import AVFoundation



class TVPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        launchTVPlayer(url: "http://10.254.253.6:8008/sport/ch1/adaptive.m3u8")
        // Do any additional setup after loading the view.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
