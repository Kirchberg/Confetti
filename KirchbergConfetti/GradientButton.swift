//
//  GradientButton.swift
//  KirchbergConfetti
//
//  Created by Kirill Kostarev on 12.06.2023.
//

import UIKit

class GradientButton: UIButton {
    private var gradientLayer: CAGradientLayer!

    override func layoutSubviews() {
        super.layoutSubviews()

        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [
                UIColor.blue.cgColor,
                UIColor.cyan.cgColor
            ]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
