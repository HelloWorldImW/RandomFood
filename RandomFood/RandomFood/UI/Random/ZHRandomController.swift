//
//  ZHRandomController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/1.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift
import AudioToolbox.AudioServices

class ZHRandomController: ZHBaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func random<T>(for items: Array<T>) -> T {
        let random = arc4random_uniform(UInt32(items.count))
        let item = items[Int(random)]
        return item
    }
    
}

/// 摇一摇
extension ZHRandomController {
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        playAudio()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
       showResult()
    }
    
    override func motionCancelled(_ motion: UIEventSubtype, with event: UIEvent?) {
        showResult()
    }
    
    private func playAudio() {
        let path = Bundle.main.path(forResource: "shake", ofType: "wav")
        var soundID: SystemSoundID = 0
        if let path = path {
            AudioServicesCreateSystemSoundID(URL(fileURLWithPath: path) as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID);
        }
    }
    
    private func showResult() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        
    }
    
}

