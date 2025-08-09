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
    var inputText: String? = "" {
        didSet {
            print("inputText")
            
            validateText()
        }
    }
    
    var resultText: String = "" {
        didSet {
            print("resultText")
            
            closureText?()
        }
    }
    
    var closureText: (() -> Void)?
    
    private func validateText() {
        guard let inputText = inputText else {
            print("텍스트를 입력해야 합니다.")
            
            return
        }
        
        do {
            _ = try validateInput(text: inputText)
            
            resultText = "\(inputText)살입니다."
        } catch AgeValidationError.isEmpty {
            resultText = "텍스트를 입력해 주세요."
        } catch AgeValidationError.isNotInt {
            resultText = "숫자를 입력해 주세요."
        } catch AgeValidationError.isNotRange {
            resultText = "1 ~ 100 사이의 숫자만 입력해 주세요"
        } catch {
            resultText = "에러!"
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
