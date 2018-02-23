//
//  Observable.swift
//  pinknoise
//
//  Created by Adam Tait on 2/19/18.
//  Copyright © 2018 Sisterical Inc. All rights reserved.
//

import Foundation



// MARK: Observable
// meant to be inherited. Primarily used by MutableProperty & MutableCollection
// tooling for managing & subscribing to observers of class instances


class Observable
{
    struct Ref
    {
        let id = NSUUID()
        let observable : Observable
        func remove() -> Bool       { return observable.removeObserver(self) }
    }
    
    
    // properties
    var observers: [(Observable) -> Void] = []
    var refs: [Ref] = []            // required for removing observers (can't compare fns)
    
    
    
    // public functions
    func addObserver(_ observer: @escaping (Observable) -> Void) -> Ref
    {
        refs.append(Ref(observable: self))
        observers.append(observer)
        return refs.last!
    }
    
    
    // intended only for classes inheriting Observable
    func notify()
    {
        observers.forEach   { $0(self) }
    }
    
    
    
    
    private func removeObserver(_ ref: Ref) -> Bool
    {
        if let index = refs.index(where: { $0 == ref } )
        {
            _ = observers.remove(at: index)
            _ = refs.remove(at: index)
            return true
        }
        return false
    }
}


extension Observable.Ref : Equatable
{
    static func ==(lhs: Observable.Ref, rhs: Observable.Ref) -> Bool
    {
        return lhs.id == rhs.id
    }
}
