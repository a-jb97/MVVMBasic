//
//  Observable.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/11/25.
//

import Foundation

class Observable<T> {
    var value: T {
        didSet {
            print("value didSet")
        }
    }
    
    init(_ value: T) {
        self.value = value
        
        print("Observable init")
    }
    
    private var action: ((T) -> Void)?
    
    func runAction(action: @escaping (T) -> Void) {
        action(value)
        
        self.action = action
        
        print("Run_Action")
    }
}
