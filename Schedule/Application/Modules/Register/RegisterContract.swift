protocol RegisterViewContract {
    
    func didRegisterSuccess()
    func didRegisterError(message: String)
}

protocol RegisterPresenterContract: class {
    
    func register(name: String, email: String, password: String)
}
