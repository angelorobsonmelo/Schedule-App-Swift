protocol ProfileViewContract {
    
    func didError(message: String)
    func didDestroySessionSuccess()
    func showUserSession(user: User)
}

protocol ProfilePresenterContract: class {
    
    func getUserSession()
    func destroySession()
}
