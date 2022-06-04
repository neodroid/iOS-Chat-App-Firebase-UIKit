//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Kevin ahmad on 04/06/22.
//

import Foundation

protocol AuthenticationProtocol {
    var formIsValid: Bool {get}
}

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
    }
}
