//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/9/25.
//

import Foundation

class CurrencyViewModel {
    var inputText = Observable("")
    
    init() {
        print("CurrencyViewModel init")
        
        inputText.runAction { _ in
            self.exchangeKRWToUSD()
        }
    }
    
//    var inputText: String? = "" {
//        didSet {
//            print("inputText")
//            
//            exchangeKRWToUSD()
//        }
//    }
    
    var resultExchangeText = Observable("")
    
//    var resultExchangeText: String = "" {
//        didSet {
//            print("resultExchangeText")
//            
//            closureText?()
//        }
//    }
    
//    var closureText: (() -> Void)?
    
    private func exchangeKRWToUSD() {
        guard let amount = Double(inputText.value) else {
            resultExchangeText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        resultExchangeText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
