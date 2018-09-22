//
//  ZHHomeViewController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/19.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import RxSwift
import AudioToolbox.AudioServices

class ZHHomeViewController: ZHBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImg(image: #imageLiteral(resourceName: "BackgroundBlur"))
        createTitle(title: "吃什么", content: "MAKING EATING A FUN THING")
        createRightBtn(img: #imageLiteral(resourceName: "more"))
        createMainUI()
        ZHProgressHUD.show(in: self.view, type: ZHProgressStatus.success)
    }
    
    private func random<T>(for items: Array<T>) -> T {
        let random = arc4random_uniform(UInt32(items.count))
        let item = items[Int(random)]
        return item
    }
}

// MARK: UI
extension ZHHomeViewController {
    func createMainUI() {
        let mainImage = UIImageView(image: #imageLiteral(resourceName: "Shakephone"))
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(202)
            make.height.equalTo(mainImage.snp.width).multipliedBy(233.0/336.0)
        }
        
        let mainTitleImage = UIImageView(image: #imageLiteral(resourceName: "Shake"))
        view.addSubview(mainTitleImage)
        mainTitleImage.snp.makeConstraints { (make) in
            make.left.equalTo(108)
            make.right.equalTo(-108)
            make.top.equalTo(mainImage.snp.bottom).offset(38)
            make.height.equalTo(mainTitleImage.snp.width).multipliedBy(47.0/158.0)
        }
    }
}

// MARK: 摇一摇
extension ZHHomeViewController {
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

