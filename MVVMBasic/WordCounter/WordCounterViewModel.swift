//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/8/25.
//

import Foundation

class WordCounterViewModel {
    var inputText: String = "" {
        didSet {
            print("inputText")
            makeCountString()
        }
    }
    
    var countString: String = "" {
        didSet {
            print("countString")
            closureText?()
        }
    }
    
    var closureText: (() -> Void)?
    
    private func makeCountString() {
        countString = "현재까지 \(inputText.count)글자 작성중"
    }
}
