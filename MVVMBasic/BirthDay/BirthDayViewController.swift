//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

enum BirthDayValidationError: Error {
    case isEmptyText
    case isNotNumber
    case isNotRangeYear
    case isNotRangeMonth
    case isNotRangeDay
}

class BirthDayViewController: UIViewController {
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        guard let yearText = yearTextField.text, let monthText = monthTextField.text, let dayText = dayTextField.text else {
            print("숫자를 입력해야 합니다.")
            
            return
        }
        
        do {
            _ = try validateInputYear(text: yearText)
            _ = try validateInputMonth(text: monthText)
            _ = try validateInputDay(text: dayText)
            
            resultLabel.text = "오늘 날짜를 기준으로 D+\(DateFormatter.untilDay(year: yearText, month: monthText, day: dayText))일째 입니다."
            
        } catch {
            switch error {
                
            case .isEmptyText:
                resultLabel.text = "텍스트를 입력해 주세요."
            
            case .isNotNumber:
                resultLabel.text = "숫자만 입력해 주세요."
                
            case .isNotRangeYear:
                resultLabel.text = "연도 형식으로 입력해 주세요."
                
            case .isNotRangeMonth:
                resultLabel.text = "월 형식으로 입력해 주세요."
                
            case .isNotRangeDay:
                resultLabel.text = "일 형식으로 입력해 주세요."
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
