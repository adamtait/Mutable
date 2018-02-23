//
//  MutableCollection.swift
//  CCW
//
//  Created by Adam Tait on 2/22/17.
//  Copyright © 2017 Adam Tait. All rights reserved.
//

import Foundation

class MutableCollection<T>: Observable where T:Hashable
{
    var coll: [T] = []
    
    override init() {
        coll = []
    }
    
    init(_ v: T) {
        coll = [v]
    }
    
    init(_ vs: [T]) {
        coll = vs
    }
}



extension MutableCollection
    // basic collection operations
{
    func first() -> T? {
        return coll.first
    }
    
    func last() -> T? {
        return coll.last
    }
    
    func at(_ i: Int) -> T? {
        if (i < coll.count)
        {
            return coll[i]
        }
        return nil
    }
    
    func count() -> Int {
        return coll.count
    }
    
    func contains(_ v: T) -> Bool
    {
        return coll.contains(v)
    }
    
    func index(of v: T) -> Int?
    {
        return coll.index(of: v)
    }
}


extension MutableCollection
    // mutate collection operations
{
    func append(_ newValue: T)
    {
        coll.append(newValue)
        notify()
    }
    
    func remove(_ v: T) -> Bool
    {
        if let i = coll.index(of: v) {
            coll.remove(at: i)
            notify()
            return true
        }
        return false
    }
    
    func shiftLeft(_ i : Int) -> Bool
    {
        if ( i > 0 && i < coll.count)
        {
            swap(i: i - 1, j: i)
            notify()
            return true
        }
        return false
    }
    
    func shiftRight(_ i : Int) -> Bool
    {
        if ( i >= 0 && i < (coll.count - 1) )
        {
            swap(i: i, j: i + 1)
            notify()
            return true
        }
        return false
    }
    
    fileprivate func swap(i: Int, j: Int)
        // ASSUMPTION: i & j are valid indicies
    {
        let v = coll[i]
        coll[i] = coll[j]
        coll[j] = v
    }
}


extension MutableCollection
    // functional collection operations
{
    func forEach(_ fn: (T) -> Void) {
        for v in coll {  fn(v)  }
    }
    
    func zip<U>(_ c: [U]) -> [T: U]
    {
        var dict: [T: U] = [:]
        let lastIndex = coll.count - 1
        for i in 0...lastIndex {
            dict[coll[i]] = c[i]
        }
        return dict
    }
    
    func map<U>(_ fn: (T) -> U) -> [U]
    {
        var results: [U] = []
        for v in coll { results.append(fn(v)) }
        return results
    }
    
    func find(_ fn: (T) -> Bool) -> Int?
    {
        for i in 0 ..< coll.count {
            if fn(coll[i])  { return i }
        }
        return nil
    }
}
