//
//  RegisterViewController.swift
//  Schedule
//
//  Created by Ângelo Melo on 27/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit
import PasswordTextField
import SwiftValidator

class RegisterViewController: BaseViewController, RegisterViewContract, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: PasswordTextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmEmailField: UITextField!
    @IBOutlet weak var confirmEmailErrorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    let validator = Validator()
    
    lazy var presenter: RegisterPresenterContract = {
        return RegisterPresenter(view: self, context: context, register: InjectionUseCase.provideRegister())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerFieldsToValidate()
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmEmailField.delegate = self
    }
    
    private func registerFieldsToValidate() {
        validator.registerField(nameField, errorLabel: nameErrorLabel,
                                rules: [RequiredRule(message: AppStrings.required_field)])
        validator.registerField(emailField, errorLabel: emailErrorLabel, rules: [RequiredRule(message: AppStrings.required_field),
                                                                                 EmailRule(message: AppStrings.invalid_email)])
        validator.registerField(confirmEmailField, errorLabel: confirmEmailErrorLabel, rules: [ConfirmationRule(confirmField: emailField)])
        validator.registerField(passwordField, errorLabel: passwordErrorLabel,
                                rules: [RequiredRule(message: AppStrings.required_field)])
    }
    
    @IBAction func register(_ sender: UIButton) {
        self.showLoading()
        validator.validate(self)
    }
    
    func didRegisterSuccess() {
        self.hideLoading()
        let alert = UIAlertController(title: "", message: "Salvo com sucesso!", preferredStyle: .alert)
        let buttonOkAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.goBack()
        })
        
        alert.addAction(buttonOkAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goBack() {
        self.hideLoading()
        dismiss(animated: true, completion: nil)
    }
    
    func didRegisterError(message: String) {
        self.hideLoading()
        self.presentAlertError(message: message)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameField:
            emailField.becomeFirstResponder()
            
        case emailField:
            confirmEmailField.becomeFirstResponder()
        
        case confirmEmailField:
            passwordField.becomeFirstResponder()
            
        case passwordField:
            view.endEditing(true)
            registerButton.sendActions(for: UIControl.Event.touchUpInside)
            
        default: break
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension RegisterViewController: ValidationDelegate {
    
    func validationSuccessful() {
        presenter.register(name: nameField.text!, email: emailField.text!, password: passwordField.text!)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        self.hideLoading()
        for (_, error) in errors {
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
        }
    }
    
}
