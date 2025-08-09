//
//  CurrencyViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/9/25.
//

import Foundation

class CurrencyViewModel {
    var inputText: String? = "" {
        didSet {
            print("inputText")
            
            exchangeKRWToUSD()
        }
    }
    
    var resultExchangeText: String = "" {
        didSet {
            print("resultExchangeText")
            
            closureText?()
        }
    }
    
    var closureText: (() -> Void)?
    
    private func exchangeKRWToUSD() {
        guard let amountText = inputText,
              let amount = Double(amountText) else {
            resultExchangeText = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1350.0 // 실제 환율 데이터로 대체 필요
        let convertedAmount = amount / exchangeRate
        resultExchangeText = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
}
