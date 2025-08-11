//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/8/25.
//

import Foundation

enum AgeValidationError: Error {
    case isNotRange
    case isEmpty
    case isNotInt
}

class AgeViewModel {
    var inputText = Observable("")
    
    init() {
        print("AgeViewModel init")
        
        inputText.runAction { _ in
            self.validateText()
        }
    }
    
    var resultText = Observable("")
    
    private func validateText() {
    // 이미 value에서 옵셔널인지 판단하기 때문에 불필요
//        guard let inputText = inputText.value else {
//            print("텍스트를 입력해야 합니다.")
//            
//            return
//        }
        
        do {
            _ = try validateInput(text: inputText.value)
            
            resultText.value = "\(inputText.value)살입니다."
        } catch AgeValidationError.isEmpty {
            resultText.value = "텍스트를 입력해 주세요."
        } catch AgeValidationError.isNotInt {
            resultText.value = "숫자를 입력해 주세요."
        } catch AgeValidationError.isNotRange {
            resultText.value = "1 ~ 100 사이의 숫자만 입력해 주세요"
        } catch {
            resultText.value = "에러!"
        }
    }
    
    private func validateInput(text: String) throws -> Bool {
        guard !(text.isEmpty) else {
            print("입력 텍스트가 없음")
            
            throw AgeValidationError.isEmpty
        }
        
        guard Int(text) != nil else {
            print("숫자가 아님")
            
            throw AgeValidationError.isNotInt
        }
        
        guard Int(text)! >= 1 && Int(text)! <= 100 else {
            print("나이 범위에 맞지 않음")
            
            throw AgeValidationError.isNotRange
        }
        
        return true
    }
}
