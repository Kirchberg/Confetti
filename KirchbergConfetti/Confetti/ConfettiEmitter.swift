//
//  ConfettiEmitter.swift
//  KirchbergConfetti
//
//  Created by Kirill Kostarev on 12.06.2023.
//

import UIKit

public enum ConfettiEmitter {

    // MARK: - Public Types

    public enum Shape: Hashable {

        case circle
        case square
        case rectangle
        case custom(CGPath)

        private static var shapesCache: [Shape: UIImage] = [:]

    }

    case shape(Shape, color: UIColor?, id: String = UUID().uuidString)
    case image(UIImage, color: UIColor?, id: String = UUID().uuidString)

    // MARK: - Internal Properties

    var id: String {
        switch self {
        case let .shape(_, _, id), let .image(_, _, id):
            return id
        }
    }

    var color: UIColor? {
        switch self {
        case let .image(_, color, _), let .shape(_, color, _):
            return color
        }
    }

    var image: UIImage {
        switch self {
        case let .shape(shape, _, _):
            return shape.image
        case let .image(image, _, _):
            return image
        }
    }

}

// MARK: - Support Properties

extension ConfettiEmitter.Shape {

    fileprivate var image: UIImage {
        if let imageFromCache = Self.shapesCache[self] {
            return imageFromCache
        } else {
            let rect = CGRect(origin: .zero, size: CGSize(width: 20.0, height: 20.0))
            let image = UIGraphicsImageRenderer(size: rect.size).image { context in
                context.cgContext.setFillColor(UIColor.white.cgColor)
                context.cgContext.addPath(path(in: rect))
                context.cgContext.fillPath()
            }
            Self.shapesCache[self] = image
            return image
        }
    }

}

// MARK: - Support Methods

extension ConfettiEmitter.Shape {

    fileprivate func path(in rect: CGRect) -> CGPath {
        switch self {
        case .circle, .square:
            return CGPath(ellipseIn: rect, transform: nil)
        case .rectangle:
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: 0, y: 0),
                CGPoint(x: rect.maxX, y: 0),
                CGPoint(x: rect.maxX, y: rect.maxY / 2),
                CGPoint(x: 0, y: rect.maxY / 2)
            ])
            return path
        case let .custom(path):
            return path
        }
    }

}
