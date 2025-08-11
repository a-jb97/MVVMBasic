//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/9/25.
//

import Foundation

enum BMIValidationError: String, Error {
    case isEmptyText = "텍스트를 입력해 주세요."
    case isNotDouble = "숫자만 입력해 주세요."
    case isNotRangeHeight = "1.4m ~ 2.3m 사이의 키만 입력해 주세요." // 범위 1.4...2.3
    case isNotRangeWeight = "30kg ~ 250kg 사이의 몸무게만 입력해 주세요." // 범위 30...250
}

class BMIViewModel {
    var inputHeightText = Observable("")
    
//    var inputHeightText: String? = "" {
//        didSet {
//            print("inputHeightText")
//            
//            validateText()
//        }
//    }
    
    var inputWeightText = Observable("")
    
//    var inputWeightText: String? = "" {
//        didSet {
//            print("inputWeightText")
//            
//            validateText()
//        }
//    }
    
    init() {
        print("BMIViewModel init")
        
        inputHeightText.runAction { _ in
            self.validateText()
        }
        
        inputWeightText.runAction { _ in
            self.validateText()
        }
    }
    
    var resultText = Observable("")
    
//    var resultText: String = "" {
//        didSet {
//            print("resultText")
//            
//            closureText?()
//        }
//    }
    
//    var closureText: (() -> Void)?
    
    var alertPresent: ((String) -> Void)?
    
    private func validateText() {
//        guard let heightText = inputHeightText, let weightText = inputWeightText else {
//            print("숫자를 입력해야 합니다.")
//            
//            return
//        }
        
        do {
            _ = try validateInputHeight(text: inputHeightText.value)
            _ = try validateInputWeight(text: inputWeightText.value)
            
            resultText.value = "당신의 BMI는 \(calculateBMI(height: Double(inputHeightText.value)!, weight: Double(inputWeightText.value)!))입니다."
            
        } catch {
            switch error {
                
            case .isEmptyText:
                resultText.value = BMIValidationError.isEmptyText.rawValue
                
                alertPresent?(BMIValidationError.isEmptyText.rawValue)
                
                // present(UIAlertController.configureAlert(message: "텍스트를 입력해 주세요!"), animated: true, completion: nil)
                
            case .isNotDouble:
                resultText.value = BMIValidationError.isNotDouble.rawValue
                
                alertPresent?(BMIValidationError.isNotDouble.rawValue)
                
                // present(UIAlertController.configureAlert(message: "숫자만 입력해 주세요!"), animated: true, completion: nil)
                
            case .isNotRangeHeight:
                resultText.value = BMIValidationError.isNotRangeHeight.rawValue
                
                alertPresent?(BMIValidationError.isNotRangeHeight.rawValue)
                
                // present(UIAlertController.configureAlert(message: "1.4m ~ 2.3m 사이의 키만 입력해 주세요!"), animated: true, completion: nil)
                
            case .isNotRangeWeight:
                resultText.value = BMIValidationError.isNotRangeWeight.rawValue
                
                alertPresent?(BMIValidationError.isNotRangeWeight.rawValue)
                
                // present(UIAlertController.configureAlert(message: "30kg ~ 250kg 사이의 몸무게만 입력해 주세요!"), animated: true, completion: nil)
                
            }
        }
    }
    
    private func calculateBMI<T: FloatingPoint>(height: T, weight: T) -> String {
        let bmi = weight / (height * height)
        let bmiString = String(format: "%.2f", bmi as! CVarArg) // CVarArg : C 언어의 가변 인자를 Swift에서 사용할 수 있도록 해주는 프로토콜
        
        return bmiString
    }
    
    private func validateInputHeight (text: String) throws(BMIValidationError) -> Bool {
        guard !(text.isEmpty) else {
            print("입력 텍스트가 없음")
            
            throw .isEmptyText
        }
        
        guard Double(text) != nil else {
            print("숫자가 아님")
            
            throw .isNotDouble
        }
        
        guard Double(text)! >= 1.4 && Double(text)! <= 2.3 else {
            print("입력 키 범위가 맞지 않음")
            
            throw .isNotRangeHeight
        }
        
        return true
    }
    
    private func validateInputWeight (text: String) throws(BMIValidationError) -> Bool {
        guard !(text.isEmpty) else {
            print("입력 텍스트가 없음")
            
            throw .isEmptyText
        }
        
        guard Double(text) != nil else {
            print("숫자가 아님")
            
            throw .isNotDouble
        }
        
        guard Double(text)! >= 30.0 && Double(text)! <= 250.0 else {
            print("입력 몸무게 범위가 맞지 않음")
            
            throw .isNotRangeWeight
        }
        
        return true
    }
}
