protocol SaveScheduleViewContract {
    
    func didSaveSuccess()
    func didRegisterError(message: String)
    func showUserSession(user: User)
}

protocol SaveSchedulePresenterContract: class {
    
    func save(title: String, shortDescription: String, detail: String, author: User)
    func getUserSession()
}
