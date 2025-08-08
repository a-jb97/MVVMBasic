//
//  Alert.swift
//  MVVMBasic
//
//  Created by 전민돌 on 8/7/25.
//

import UIKit

extension UIAlertController {
    static func configureAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        return alert
    }
}
