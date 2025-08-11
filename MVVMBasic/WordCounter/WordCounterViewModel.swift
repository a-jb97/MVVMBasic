//
//  WordCounterViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/8/25.
//

import Foundation

class WordCounterViewModel {
    var inputText = Observable("")
    
    init() {
        print("WordCounterViewModel init")
        
        inputText.runAction { _ in
            self.makeCountText()
        }
    }
    
//    var inputText: String = "" {
//        didSet {
//            print("inputText")
//            
//            makeCountText()
//        }
//    }
    
//    var countText: String = "" {
//        didSet {
//            print("countString")
//            
//            closureText?()
//        }
//    }
    
    var countText = Observable("")
    
    // Observable 사용으로 이제 사용 X
    // var closureText: (() -> Void)?
    
    private func makeCountText() {
        countText.value = "현재까지 \(inputText.value.count)글자 작성중"
    }
}
