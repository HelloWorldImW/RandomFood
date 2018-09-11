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
    @IBOutlet weak private var deleteBtn: UIButton!
    weak private var tableView: UITableView?
    private var deleteEvent: ((IndexPath?)->Void)?
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    class func cell(for tableView: UITableView, isEdit: Bool = false) -> ZHShowItemCell {
        var cell: ZHShowItemCell? = tableView.dequeueReusableCell(withIdentifier: "ZHShowItemCell") as? ZHShowItemCell
        if cell == nil {
            let cellNib = UINib.init(nibName: "ZHShowItemCell", bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: "ZHShowItemCell")
            cell = cellNib.instantiate(withOwner: self, options: nil).last as? ZHShowItemCell
        }
        if !isEdit && cell?.deleteBtn != nil {
            cell?.deleteBtn.removeFromSuperview()
        }
        cell?.tableView = tableView
        cell?.selectionStyle = .none
        return cell!
    }
    
    func addDeleteEvent(event: ((IndexPath?)->Void)?) {
        deleteEvent = event
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func deleteBtnClicked(_ sender: UIButton) {
        if let event = deleteEvent {
            if let tableView = tableView {
                let indexpath = tableView.indexPath(for: self)
                event(indexpath)
            }
        }
    }
}
