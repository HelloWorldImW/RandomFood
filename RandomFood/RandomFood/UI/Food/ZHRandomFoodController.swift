//
//  ZHRandomFoodController.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/30.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHRandomFoodController: UIViewController {

    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func locationClicked(_ sender: UITapGestureRecognizer) {
        let animations = [#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "location_light")]
        locationIcon.animationImages = animations
        locationIcon.animationDuration = 0.8
        locationIcon.startAnimating()
        tipLabel.isHidden = true
    }

}

extension ZHRandomFoodController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        view.backgroundColor = UIColor.red
        return view
    }
    
}

