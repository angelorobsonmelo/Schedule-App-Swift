//
//  RecoverPasswordViewController.swift
//  Schedule
//
//  Created by Ângelo Melo on 28/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit
import SwiftValidator
import MessageUI
import SwiftKeychainWrapper

class RecoverPasswordViewController: BaseViewController, UITextFieldDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var recoverPasswordButton: UIButton!
    
    let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        registerFieldsToValidate()
    }
    
    private func registerFieldsToValidate() {
        validator.registerField(emailField, errorLabel: emailErrorLabel, rules: [RequiredRule(message: AppStrings.required_field),
                                                                                 EmailRule(message: AppStrings.invalid_email)])
    }

    @IBAction func recoverPassword(_ sender: UIButton) {
        validator.validate(self)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([emailField.text!])
        let newPassword = randomString(length: 6)
        mailComposerVC.setSubject("Schedule App")
        mailComposerVC.setMessageBody("Your password is: \(newPassword)", isHTML: false)
        savePassword(email: emailField.text!, password: newPassword)
        return mailComposerVC
    }
    
    fileprivate func savePassword(email: String, password: String) {
        KeychainWrapper.standard.set(password, forKey: email)
    }
    
    fileprivate func userAlreadyExists(email: String) -> Bool {
        let emailReturned: String? = KeychainWrapper.standard.string(forKey: email)
        if emailReturned != nil {
            return true
        }
        
        return false
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map { _ in letters.randomElement()! })
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension RecoverPasswordViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            view.endEditing(true)
            recoverPasswordButton.sendActions(for: UIControl.Event.touchUpInside)
            
        default: break
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension RecoverPasswordViewController: ValidationDelegate {
    
    func validationSuccessful() {
        if userAlreadyExists(email: emailField.text!) {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }
        } else {
            self.presentAlertError(message: "Unregistered E-mail")
        }
        
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        self.hideLoading()
        for (_, error) in errors {
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
        }
    }
    
}
