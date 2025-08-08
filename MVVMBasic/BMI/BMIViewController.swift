//
//  BMIViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum BMIValidationError: Error {
    case isEmptyText
    case isNotDouble
    case isNotRangeHeight // 범위 1.4...2.3
    case isNotRangeWeight // 범위 30...250
}

class BMIViewController: UIViewController {
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "키를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "몸무게를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("클릭", for: .normal)
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
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        heightTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(heightTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(20)
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
        
        guard let heightText = heightTextField.text, let weightText = weightTextField.text else {
            print("숫자를 입력해야 합니다.")
            
            return
        }
        
        do {
            _ = try validateInputHeight(text: heightText)
            _ = try validateInputWeight(text: weightText)
            
            resultLabel.text = "당신의 BMI는 \(calculateBMI(height: Double(heightText)!, weight: Double(weightText)!))입니다."
            
        } catch {
            switch error {
                
            case .isEmptyText:
                resultLabel.text = "텍스트를 입력해 주세요."
                
                present(UIAlertController.configureAlert(message: "텍스트를 입력해 주세요!"), animated: true, completion: nil)
                
            case .isNotDouble:
                resultLabel.text = "숫자만 입력해 주세요."
                
                present(UIAlertController.configureAlert(message: "숫자만 입력해 주세요!"), animated: true, completion: nil)
                
            case .isNotRangeHeight:
                resultLabel.text = "1.4m ~ 2.3m 사이의 키만 입력해 주세요."
                
                present(UIAlertController.configureAlert(message: "1.4m ~ 2.3m 사이의 키만 입력해 주세요!"), animated: true, completion: nil)
                
            case .isNotRangeWeight:
                resultLabel.text = "30kg ~ 250kg 사이의 몸무게만 입력해 주세요."
                
                present(UIAlertController.configureAlert(message: "30kg ~ 250kg 사이의 몸무게만 입력해 주세요!"), animated: true, completion: nil)
                
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
        
        guard Int(text) != nil else {
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
