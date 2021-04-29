//
//  UIView+Extensions.swift
//  Sirius
//
//  Created by Oleksandr Stepanov on 11/12/19.
//  Copyright © 2019 Kromtech. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /// Load the view from a nib file called with the name of the class
    ///
    /// - Note: The first object of the nib file **must** be of the matching class
    static func loadFromNib() -> Self {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: String(describing: self), bundle: bundle)
        // swiftlint:disable force_cast
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
        // swiftlint:enable force_cast
    }

    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
           layer.cornerRadius = newValue
        }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
           layer.borderWidth = newValue
        }
    }

    @IBInspectable public var borderColor: UIColor {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            }
            return UIColor.clear
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    func fill(in view: UIView, atIndex: Int? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let index = atIndex {
            view.insertSubview(self, at: index)
        } else {
            view.addSubview(self)
        }

        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    var heightConstraint: NSLayoutConstraint? {
        self.constraints.filter { $0.identifier == "height" }.first
    }

    func callRecursively(level: Int = 0, _ body: (_ subview: UIView, _ level: Int) -> Void) {
        body(self, level)
        subviews.forEach { $0.callRecursively(level: level + 1, body) }
    }

    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
