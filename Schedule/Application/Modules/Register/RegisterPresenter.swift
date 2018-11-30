//
//  RegisterPresenter.swift
//  Schedule
//
//  Created by Ângelo Melo on 28/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import Foundation
import CoreData

class RegisterPresenter: RegisterPresenterContract {
    
    private let view: RegisterViewContract
    private let context: NSManagedObjectContext
    private let register: Register

    init(view: RegisterViewContract, context: NSManagedObjectContext, register: Register) {
        self.view     = view
        self.context  = context
        self.register = register
    }
    
    func register(name: String, email: String, password: String) {
        let user   = User(context: context)
        user.name  = name
        user.email = email
        
        register.register(user: user, password: password) { (callback) in
            callback.onSuccess({ (_) in
                self.view.didRegisterSuccess()
            })
            callback.onFailed({ (error) in
                if let error = error {
                   self.view.didRegisterError(message: error as? String ?? "Error")
                }
            })
        }
        
    }
    
}
