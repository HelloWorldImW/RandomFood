//
//  ZHProgressHUD.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import RxSwift

enum ZHProgressStatus: String {
    case loading = "检索中..."
    case success = "检索成功"
    case failed = "检索失败"
}

class ZHProgressHUD: UIView {
    
// MARK: Public Methods
    
    @discardableResult
    class func show(in superView: UIView, type: ZHProgressStatus) -> ZHProgressHUD {
        let hud = ZHProgressHUD(type: type)
        superView.addSubview(hud)
        hud.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        return hud
    }
    
    func changeToLoading() {
        createUI(type: .loading)
    }
    
    func changeToFailed(retry:()->Void) {
        createUI(type: .failed)
    }
    
    func changeToSuccess() {
        createUI(type: .loading)
    }
    
// MARK: Private Methods
    private let disposebag = DisposeBag()
    
    private lazy var animationImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .center
        return title
    }()
    
    private lazy var contentLabel: UILabel = {
        let content = UILabel()
        content.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        content.font = UIFont.systemFont(ofSize: 12)
        content.textAlignment = .center
        return content
    }()

    private lazy var retryBtn: UIButton = {
        let retry = UIButton(type: UIButtonType.system)
        retry.setBackgroundImage(#imageLiteral(resourceName: "button_retry"), for: .normal)
        return retry
    }()
    
    private var type = ZHProgressStatus.loading
    
    private convenience init(type: ZHProgressStatus) {
        self.init()
        self.backgroundColor = UIColor.white
        addSubview(animationImageView)
        addSubview(titleLabel)
        animationImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(ZHScreenHeight*0.09)
            make.height.equalTo(ZHScreenHeight*0.43)
            make.width.equalTo(animationImageView.snp.height).multipliedBy(307.0/283.0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(animationImageView.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(72)
        }
        createUI(type: type)
    }
    
    private func createUI(type: ZHProgressStatus, retry:(()->Void)? = nil) {
        self.type = type
        titleLabel.text = type.rawValue
        switch type {
        case .loading:
            let path = Bundle.main.path(forResource: "animation_location.gif", ofType: "")
            let imgData = NSData(contentsOfFile: path!)!
            animationImageView.image = UIImage.sd_animatedGIF(with: imgData as Data?)
            hideError()
        case .success:
            animationImageView.image = #imageLiteral(resourceName: "location_succeed")
            hideError()
        case .failed:
            animationImageView.image = #imageLiteral(resourceName: "location_error")
            showError(retry: retry)
        }
    }
    
    private func hideError() {
        if subviews.contains(contentLabel) {
            contentLabel.removeFromSuperview()
        }
        if subviews.contains(retryBtn) {
            retryBtn.removeFromSuperview()
        }
    }
    
    private func showError(retry: (()->Void)?) {
        contentLabel.text = "请检查网络后重试"
        addSubview(contentLabel)
        addSubview(retryBtn)
        
        retryBtn.rx.tap.subscribe(onNext: {
            if let retry = retry {
                retry()
            }
        }).disposed(by: disposebag)
        
        contentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(ZHScreenHeight*0.015)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(124)
        }
        retryBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(ZHScreenHeight*0.094)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(123)
        }
    }
}
