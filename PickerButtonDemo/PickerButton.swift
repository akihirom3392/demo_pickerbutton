//
//  PickerButton.swift
//  PickerButtonDemo
//
//  Created by Akihiro Matsui on 2/12/19.
//  Copyright © 2019 USO400.net. All rights reserved.
//

import UIKit

class PickerButton: UIButton, UIPickerViewDataSource, UIPickerViewDelegate {
    private let accessoryView = UIView()
    private let pickerView = UIPickerView()
    private let okButton = UIButton(type: .custom)
    private let cancelButton = UIButton(type: .custom)

    override var inputAccessoryView: UIView? { return self.accessoryView }
    override var inputView: UIView? { return self.pickerView }
    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.accessoryView.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        pickerView.delegate = self
        pickerView.dataSource = self

        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)
        okButton.setTitleColor(UIColor.darkGray, for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)

        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        cancelButton.setTitleColor(UIColor.darkGray, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)

        accessoryView.backgroundColor = UIColor.lightGray
        accessoryView.addSubview(cancelButton)
        accessoryView.addSubview(okButton)
        accessoryView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)

        accessoryView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:[view(==100)]-10-|",
                                           options: [],
                                           metrics: nil,
                                           views: ["view": okButton]))
        accessoryView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[view]-5-|",
                                           options: [],
                                           metrics: nil,
                                           views: ["view": okButton]))

        accessoryView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[view(==100)]",
                                           options: [],
                                           metrics: nil,
                                           views: ["view": cancelButton]))
        accessoryView.addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[view]-5-|",
                                           options: [],
                                           metrics: nil,
                                           views: ["view": cancelButton]))

    }

    @objc
    func okButtonTapped(_ sender: UIButton) {
        print("ok")
        self.resignFirstResponder()
    }

    @objc
    func cancelButtonTapped(_ sender: UIButton) {
        print("cancel")
        self.resignFirstResponder()
    }

    @objc
    func tapped(_ sender: UIButton) {
        print("tapped")
        self.becomeFirstResponder()
    }

    // MARK: --- UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }

    // MARK: --- UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: "Number Of \(row)")
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected: \(component),\(row)")
    }


}
