//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

enum AgeValidationError: Error {
    case isNotRange
    case isEmpty
    case isNotInt
}

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
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
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
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
        
        guard let inputText = textField.text else {
            print("텍스트를 입력해야 합니다.")
            
            return
        }
        
        do {
            _ = try validateInput(text: inputText)
            
            label.text = "\(inputText)살입니다."
        } catch AgeValidationError.isEmpty {
            label.text = "텍스트를 입력해 주세요."
        } catch AgeValidationError.isNotInt {
            label.text = "숫자를 입력해 주세요."
        } catch AgeValidationError.isNotRange {
            label.text = "1 ~ 100 사이의 숫자만 입력해 주세요"
        } catch {
            label.text = "에러!"
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
