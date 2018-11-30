import UIKit
import PasswordTextField
import SwiftValidator

class LoginViewController: BaseViewController, LoginViewContract, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: PasswordTextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    let validator = Validator()

    lazy var presenter: LoginPresenterContract = {
        return LoginPresenter(view: self,
                              getUserSession: InjectionUseCase.provideGetUserSession(),
                              saveSession: InjectionUseCase.provideSaveSession(),
                              context: context)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerFieldsToValidate()
        configFormElements()
    }
    
    private func registerFieldsToValidate() {
        validator.registerField(emailField, errorLabel: emailErrorLabel, rules: [RequiredRule(message: AppStrings.required_field),
                                                         EmailRule(message: AppStrings.invalid_email)])
        validator.registerField(passwordField, errorLabel: passwordErrorLabel,
                                rules: [RequiredRule(message: AppStrings.required_field)])
    }
    
    fileprivate func configFormElements() {
        configEmailTextField()
        configPasswordTextField()
        configLoginButton()
    }
    
    fileprivate func configEmailTextField() {
        emailField.delegate = self
        emailField.setPlaceHolder(placeHolderText: AppStrings.login_view_controller_email_text_field_placeholder)
    }
    
    fileprivate func configPasswordTextField() {
        passwordField.delegate = self
        passwordField.setPlaceHolder(placeHolderText: AppStrings.login_view_controller_password_field_placeholder)
    }
    
    fileprivate func configLoginButton() {
        loginButton.setRoundCorners()
        loginButton.setTitle(AppStrings.login_view_controller_button_title, for: .normal)
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.showLoading()
        validator.validate(self)
    }
  
    func didLoginSuccess() {
        self.hideLoading()
        performSegue(withIdentifier: "scheduleSegue", sender: nil)
    }
    
    func didLoginError(message: String) {
        self.hideLoading()
        self.presentAlertError(message: message)
    }
    
}

extension LoginViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
            
        case passwordField:
            view.endEditing(true)
            loginButton.sendActions(for: UIControl.Event.touchUpInside)
            
        default: break
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension LoginViewController: ValidationDelegate {
    
    func validationSuccessful() {
        presenter.login(email: emailField.text!, password: passwordField.text!)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        self.hideLoading()
        for (_, error) in errors {
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.isHidden = false
        }
    }
    
}
