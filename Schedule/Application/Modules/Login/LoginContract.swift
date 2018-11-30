protocol LoginViewContract {
    
    func didLoginSuccess()
    func didLoginError(message: String)
}

protocol LoginPresenterContract: class {
    
    func login(email: String, password: String) 
}
