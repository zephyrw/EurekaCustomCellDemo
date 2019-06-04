//
//  UpdateCell.swift
//  EurekaCustomCellDemo
//
//  Created by Zephyr on 2019/6/4.
//  Copyright © 2019 zephyr. All rights reserved.
//

import UIKit
import Eureka

final class UpdateCell: Cell<Software>, CellType {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var aniContainerView: UIView!
    @IBOutlet weak var noNeedUpdateLabel: UILabel!
    
    private var shapeLayer = CAShapeLayer()
    
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        
        selectionStyle = .none
        height = { return 44 }
        
        let arcCenter = CGPoint(x: aniContainerView.frame.width / 2, y: aniContainerView.frame.height / 2)
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: aniContainerView.frame.width / 2, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi / 2 * 3, clockwise: true)
        let lineW: CGFloat = 4
        let bgShapeLayer = CAShapeLayer()
        bgShapeLayer.path = circlePath.cgPath
        bgShapeLayer.frame = aniContainerView.bounds
        bgShapeLayer.strokeColor = UIColor(red: 224.0 / 255.0, green: 224.0 / 255.0, blue: 224.0 / 255.0, alpha: 1).cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = lineW
        bgShapeLayer.strokeEnd = 1
        aniContainerView.layer.addSublayer(bgShapeLayer)
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.frame = aniContainerView.bounds
        shapeLayer.strokeColor = UIColor(red: 71 / 255.0, green: 197 / 255.0, blue: 246 / 255.0, alpha: 1).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = lineW
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        aniContainerView.layer.addSublayer(shapeLayer)

    }
    
    override func update() {
        guard let software = row.value else {
            return
        }
        titleLabel.text = software.name
        updateUI(software.updateState)
    }
    
    private func updateUI(_ updateState: UpdateState) {
        switch updateState {
        case .toUpdate:
            updateButton.isHidden = false
            aniContainerView.isHidden = true
            noNeedUpdateLabel.isHidden = true
        case .updating:
            updateButton.isHidden = true
            aniContainerView.isHidden = false
            noNeedUpdateLabel.isHidden = true
            startAni(0)
        case .alreadyNewest:
            updateButton.isHidden = true
            aniContainerView.isHidden = true
            noNeedUpdateLabel.isHidden = false
        }
    }
    
    func startAni(_ seconds: TimeInterval) {
        var seconds = seconds
        if seconds < 10 {
            seconds += 1
            shapeLayer.strokeEnd = CGFloat(seconds / 10.0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.startAni(seconds)
            })
        } else {
            updateUI(.alreadyNewest)
        }
    }

    
    @IBAction func updateButtonClick(_ sender: UIButton) {
        updateUI(.updating)
    }
    
}

final class UpdateRow: Row<UpdateCell>, RowType {
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<UpdateCell>(nibName: "UpdateCell")
    }
    
}
