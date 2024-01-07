//
//  LoginViewModel.swift
//  Shopping App
//
//  Created by Avinash Kumar on 07/01/24.
//

import Foundation

class LoginViewModel {
    func performValidationForEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
