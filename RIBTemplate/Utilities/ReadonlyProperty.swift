//
//  ReadonlyProperty.swift
//  Sirius
//
//  Created by Oleksandr Stepanov on 8/29/19.
//  Copyright © 2019 Kromtech. All rights reserved.
//

import RxSwift
import RxCocoa

/// A get-only `BehaviorRelay` that works similar to ReactiveSwift's `Property`.
public final class ReadonlyProperty<Element>: ObservableType {

    fileprivate let _behaviorRelay: BehaviorRelay<Element>

    /// Gets current value.
    public var value: Element {
        return _behaviorRelay.value
    }

    /// Initializes with initial value.
    public init(_ value: Element) {
        _behaviorRelay = BehaviorRelay(value: value)
    }

    /// Initializes with `BehaviorRelay`.
    public init(_ behaviorRelay: BehaviorRelay<Element>) {
        _behaviorRelay = behaviorRelay
    }

    /// Initializes with `initial` element and then `observable`.
    public init(initial: Element, then observable: Observable<Element>) {
        _behaviorRelay = BehaviorRelay(value: initial)

        _ = observable
            .bind(to: _behaviorRelay)
        // .disposed(by: disposeBag)    // Comment-Out: Don't dispose when `property` is deallocated
    }

    /// Observable that only sends changed elements, ignoring current element.
    /// This is same as `ReactiveSwift.Property<T>.signal`.
    public var changed: Observable<Element> {
        return asObservable().skip(1)
    }

    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
        return _behaviorRelay.subscribe(observer)
    }
}

@propertyWrapper
final class Readwrite<Element> {

    var wrappedValue: ReadonlyProperty<Element>

    init(wrappedValue: ReadonlyProperty<Element>) {
        self.wrappedValue = wrappedValue
    }

    func accept(_ event: Element) {
        wrappedValue._behaviorRelay.accept(event)
    }

    var relay: BehaviorRelay<Element> {
        return wrappedValue._behaviorRelay
    }
}
