//
//  ZHAddNewItemCell.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/11.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHAddNewItemCell: UITableViewCell {

    class func cell(for tableView: UITableView) -> ZHAddNewItemCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ZHAddNewItemCell")
        if cell == nil {
            let cellNib = UINib.init(nibName: "ZHAddNewItemCell", bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: "ZHAddNewItemCell")
            cell = cellNib.instantiate(withOwner: self, options: nil).last as! ZHAddNewItemCell
        }
        cell?.selectionStyle = .none
        return cell as! ZHAddNewItemCell;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
