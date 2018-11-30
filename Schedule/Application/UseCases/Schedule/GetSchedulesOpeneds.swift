import CoreData

class GetSchedulesOpeneds {
    
    private weak var localDataSource: ScheduleLocalDataSource?
    
    init(localDataSource: ScheduleLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func getSchedules(context: NSManagedObjectContext, _ scheduleCallBack: @escaping (BaseCallback<[Schedule]>) -> Void) {
        localDataSource?.getSchedulesOpeneds(context: context, { (callBack) in
            callBack.onSuccess({ (schedules) in
                let callbackSuccess = BaseCallback.success(schedules)
                scheduleCallBack(callbackSuccess)
            })
            callBack.onFailed({ (error) in
                let callbackFailed = BaseCallback<[Schedule]>.failed(error: error)
                scheduleCallBack(callbackFailed)
                })
        })
        
    }
    
}
