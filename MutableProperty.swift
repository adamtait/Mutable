//
//  MutableProperty.swift
//  pinknoise
//
//  Created by Adam Tait on 2/19/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation



// MARK: Mutable Property
//  generic implementation of Observable

class MutableProperty<T>: Observable
{
    private var history: [T] = []
    
    init(_ newValue: T) {
        history.append(newValue)
    }
    
    func get() -> T? {
        return history.last
    }
    
    func getPrevious() -> T? {
        let c = history.count
        if c >= 2    { return history[c - 2] }
        return nil
    }
    
    func set(_ newValue: T)
    {
        history.append(newValue)
        notify()
    }
}
