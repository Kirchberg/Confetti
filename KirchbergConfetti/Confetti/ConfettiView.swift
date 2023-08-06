//
//  ConfettiView.swift
//  KirchbergConfetti
//
//  Created by Kirill Kostarev on 12.06.2023.
//

import UIKit

public final class ConfettiView: UIView {

    // MARK: - Public Types

    public enum Direction {
        case left
        case right
        case top
        case bottom
    }

    public enum Animation {
        case `default`
    }

    // MARK: - Public Init

    public init(
        emitters: [ConfettiEmitter],
        direction: Direction,
        animation: Animation
    ) {
        self.emitters = emitters
        self.direction = direction
        self.animation = animation
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods

    public override func willMove(toSuperview newSuperview: UIView?) {
        guard let superview = newSuperview else { return }
        frame = superview.bounds
        isUserInteractionEnabled = false
    }

    public func emit() {
        switch direction {
        case .left:
            emitLeft(emitters, animation: animation)
        case .right:
            emitRight(emitters, animation: animation)
        case .top:
            emitTop(emitters, animation: animation)
        case .bottom:
            emitBottom(emitters, animation: animation)
        }
    }

    public func clear() {
        layer.removeAllAnimations()
        layer.sublayers?.forEach {
            $0.removeAllAnimations()
            $0.removeFromSuperlayer()
        }
    }

    // MARK: - Private Properties

    private let emitters: [ConfettiEmitter]
    private let direction: Direction
    private let animation: Animation

    // MARK: - Private Methods

    private func emitLeft(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .left)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func emitRight(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .right)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func emitTop(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .top)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func emitBottom(_ emitters: [ConfettiEmitter], animation: Animation) {
        let confettiLayer = ConfettiLayer(emitters, .bottom)
        configure(confettiLayer: confettiLayer, animation: animation)
    }

    private func addGravityAnimation(to layer: CAEmitterLayer, emitters: [ConfettiEmitter]) {
        let animation = CAKeyframeAnimation()
        animation.duration = 4.0
        animation.keyTimes = [0, 0.2, 0.4, 0.6, 1]
        animation.values = [10, 20, 40, 80, 4000]
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)

        for emitter in emitters {
            layer.add(animation, forKey: "emitterCells.\(emitter.id).yAcceleration")
        }
    }

    private func addBirthrateAnimation(to layer: CAEmitterLayer) {
        let animation = CABasicAnimation()
        animation.duration = 1
        animation.fromValue = 1
        animation.toValue = 0

        layer.add(animation, forKey: "birthRate")
        layer.birthRate = 0
    }

    private func configure(
        confettiLayer: ConfettiLayer,
        animation: Animation
    ) {
        confettiLayer.frame = self.bounds
        confettiLayer.needsDisplayOnBoundsChange = true

        layer.addSublayer(confettiLayer)

        CATransaction.begin()
        switch animation {
        case .`default`:
            addGravityAnimation(to: confettiLayer, emitters: emitters)
            addBirthrateAnimation(to: confettiLayer)
        }
        CATransaction.commit()
    }

}

// MARK: - Custom Styles

extension ConfettiView {

    public static let top = ConfettiView(
        emitters: Static.defaultEmitters,
        direction: .top,
        animation: .default
    )

    public static let left = ConfettiView(
        emitters: Static.defaultEmitters,
        direction: .left,
        animation: .default
    )

    public static let right = ConfettiView(
        emitters: Static.defaultEmitters,
        direction: .left,
        animation: .default
    )

    public static let bottom = ConfettiView(
        emitters: Static.defaultEmitters,
        direction: .bottom,
        animation: .default
    )

    private enum Static {
        static let defaultEmitters: [ConfettiEmitter] = [
            .shape(.rectangle, color: .systemRed),
            .shape(.rectangle, color: .systemPink),
            .shape(.rectangle, color: .systemYellow),
            .shape(.rectangle, color: .systemTeal),
            .shape(.rectangle, color: .systemBlue),
            .shape(.circle, color: .systemGreen),
            .shape(.circle, color: .systemRed),
            .shape(.circle, color: .systemPink),
            .shape(.circle, color: .systemYellow),
            .shape(.circle, color: .systemTeal),
            .shape(.circle, color: .systemBlue),
            .shape(.circle, color: .systemGreen)
        ]
    }

}
