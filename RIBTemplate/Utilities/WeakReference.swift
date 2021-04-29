//
//  WeakReference.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 27.04.2021.
//

import Foundation

class WeakReference<T> where T: AnyObject {
    private(set) weak var value: T?
    init(value: T?) {
        self.value = value
    }
}
