//
//  BirthDayViewModel.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/9/25.
//

import Foundation

enum BirthDayValidationError: Error {
    case isEmptyText
    case isNotNumber
    case isNotRangeYear
    case isNotRangeMonth
    case isNotRangeDay
}

class BirthDayViewModel {
    var inputYearText: String? = "" {
        didSet {
            print("inputYearText")
            
            validateText()
        }
    }
    
    var inputMonthText: String? = "" {
        didSet {
            print("inputMonthText")
            
            validateText()
        }
    }
    
    var inputDayText: String? = "" {
        didSet {
            print("inputDayText")
            
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
        guard let yearText = inputYearText, let monthText = inputMonthText, let dayText = inputDayText else {
            print("숫자를 입력해야 합니다.")
            
            return
        }
        
        do {
            _ = try validateInputYear(text: yearText)
            _ = try validateInputMonth(text: monthText)
            _ = try validateInputDay(text: dayText)
            
            resultText = "오늘 날짜를 기준으로 D+\(DateFormatter.untilDay(year: yearText, month: monthText, day: dayText))일째 입니다."
            
        } catch {
            switch error {
                
            case .isEmptyText:
                resultText = "텍스트를 입력해 주세요."
            
            case .isNotNumber:
                resultText = "숫자만 입력해 주세요."
                
            case .isNotRangeYear:
                resultText = "연도 형식으로 입력해 주세요."
                
            case .isNotRangeMonth:
                resultText = "월 형식으로 입력해 주세요."
                
            case .isNotRangeDay:
                resultText = "일 형식으로 입력해 주세요."
            }
        }
    }
    
    private func validateInputYear(text: String) throws(BirthDayValidationError) -> Bool {
        guard !(text.isEmpty) else {
            print("입력 텍스트 없음")
            
            throw .isEmptyText
        }
        
        guard Int(text) != nil else {
            print("숫자가 아님")
            
            throw .isNotNumber
        }
        
        guard DateFormatter.checkYear(text: text) else {
            print("연도 형식에 맞지 않음")
            
            throw .isNotRangeDay
        }
        
        return true
    }
    
    private func validateInputMonth(text: String) throws(BirthDayValidationError) -> Bool {
        guard !(text.isEmpty) else {
            print("입력 텍스트 없음")
            
            throw .isEmptyText
        }
        
        guard Int(text) != nil else {
            print("숫자가 아님")
            
            throw .isNotNumber
        }
        
        guard DateFormatter.checkMonth(text: text) else {
            print("월 형식에 맞지 않음")
            
            throw .isNotRangeMonth
        }
        
        return true
    }
    
    private func validateInputDay(text: String) throws(BirthDayValidationError) -> Bool {
        guard !(text.isEmpty) else {
            print("입력 텍스트 없음")
            
            throw .isEmptyText
        }
        
        guard Int(text) != nil else {
            print("숫자가 아님")
            
            throw .isNotNumber
        }
                
        guard DateFormatter.checkDay(text: text) else {
            print("일 형식에 맞지 않음")
            
            throw .isNotRangeDay
        }
        
        return true
    }
}
