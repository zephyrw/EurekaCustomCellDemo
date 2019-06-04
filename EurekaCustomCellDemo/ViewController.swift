//
//  ViewController.swift
//  EurekaCustomCellDemo
//
//  Created by Zephyr on 2019/6/4.
//  Copyright © 2019 zephyr. All rights reserved.
//

import UIKit
import Eureka

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }

    private func setupForm() {
        form +++ Section()
            <<< LabelRow() {
            $0.title = "LabelRow"
            $0.value = "Default Value"
            }.cellSetup({ (cell, row) in
                cell.accessoryType = .disclosureIndicator
            }).onCellSelection({ (cell, row) in
                print("cell selection")
            })
            <<< TextRow(tag: "TextRow")
                .cellSetup({ (cell, row) in
                    row.tag = "TextRow"
                    row.title = "TextRow"
                    row.placeholder = "Input your message"
                })
                .cellUpdate({ (cell, row) in
                    print("cell update")
                })
            <<< SwitchRow() {
                $0.tag = "SwitchValue"
                $0.title = "SwitchRow"
                $0.value = true
                }.onChange({ (row) in
                    print("value changed: \(row.value ?? false)")
                })
            +++ Section()
            <<< UpdateRow() {
                $0.value = Software(name: "My Software", updateState: .toUpdate)
        }
    }
    
}

