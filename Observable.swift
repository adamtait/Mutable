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
        let id          = NSUUID()
        let observable  : Observable
        let observer    : (Observable) -> Void
        
        func remove() -> Bool       { return observable.removeObserver(self) }
        func notify()               { observer(observable) }
    }
    
    
    // properties
    var refs: [Ref] = []
    
    
    
    // public functions
    func addObserver(_ observer: @escaping (Observable) -> Void) -> Ref
    {
        let ref = Ref(observable: self, observer: observer)
        refs.append(ref)
        return ref
    }
    
    
    // intended only for classes inheriting Observable
    func notify()
    {
        refs.forEach   { $0.notify() }
    }
    
    
    
    private func removeObserver(_ ref: Ref) -> Bool
    {
        if let index = refs.index(where: { $0 == ref } )
        {
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
