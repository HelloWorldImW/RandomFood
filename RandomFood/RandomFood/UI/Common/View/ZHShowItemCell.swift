//
//  ZHShowItemCell.swift
//  RandomFood
//
//  Created by DarrenW on 2018/9/8.
//  Copyright © 2018年 Darren. All rights reserved.
//

import UIKit

class ZHShowItemCell: UITableViewCell {
    
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var deleteBtn: UIButton!
    private var deleteEvent: ((ZHShowItemCell)->Void)?
    private var editEvent: ((Bool, ZHShowItemCell, String)->Void)?
    private var isDelete: Bool = false
    
    var title: String? {
        didSet {
            titleTextField.text = title
        }
    }
    
    var canEdit: Bool = false {
        didSet {
            titleTextField.isEnabled = canEdit
        }
    }
    
    func becomeActive() {
        self.titleTextField.becomeFirstResponder()
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
        cell?.isDelete = false
        cell?.selectionStyle = .none
        return cell!
    }
    
    @discardableResult
    func addDeleteEvent(event: ((ZHShowItemCell)->Void)?) -> ZHShowItemCell {
        deleteEvent = event
        return self
    }
    
    @discardableResult
    func addEditEvent(event: ((Bool, ZHShowItemCell, String)->Void)?) -> ZHShowItemCell {
        editEvent = event
        return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction private func deleteBtnClicked(_ sender: UIButton) {
        if let event = deleteEvent {
            isDelete = true
            event(self)
        }
    }
}

extension ZHShowItemCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        doneCallback(with: textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        doneCallback(with: textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let event = editEvent {
            event(false, self, "")
        }
    }
    
    private func doneCallback(with textField: UITextField) {
        textField.resignFirstResponder()
        if let event = editEvent,
            !isDelete {
            event(true, self, textField.text!)
        }
    }
}

