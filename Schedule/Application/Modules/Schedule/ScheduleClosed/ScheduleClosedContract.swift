protocol ScheduleClosedViewContract {
    
    func showSchedulesCloseds(schedues: [Schedule])
    func didSchedulesError(message: String)
    func didDestroySessionSuccess()
    func reopenSuccessfully()
}

protocol ScheduleClosedPresenterContract: class {
    
    func getSchedulesCloseds()
    func destroySession()
    func reopen(schedule: Schedule)
}
