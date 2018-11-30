protocol ScheduleOpenedViewContract {
    
    func showSchedulesOpeneds(schedues: [Schedule])
    func didSchedulesError(message: String)
    func didDestroySessionSuccess()
    func closeSuccessfully()
}

protocol ScheduleOpenedPresenterContract: class {
    
    func getSchedulesOpeneds()
    func destroySession()
    func close(schedule: Schedule)
}
