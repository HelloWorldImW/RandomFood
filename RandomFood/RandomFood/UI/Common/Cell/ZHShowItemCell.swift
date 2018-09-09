//
//  ZHShowItemCell.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/8.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHShowItemCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    class func cell(for tableView: UITableView) -> ZHShowItemCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ZHShowItemCell")
        if cell == nil {
            let cellNib = UINib.init(nibName: "ZHShowItemCell", bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: "ZHShowItemCell")
            cell = cellNib.instantiate(withOwner: self, options: nil).last as! ZHShowItemCell
        }
        cell?.selectionStyle = .none
        return cell as! ZHShowItemCell;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
