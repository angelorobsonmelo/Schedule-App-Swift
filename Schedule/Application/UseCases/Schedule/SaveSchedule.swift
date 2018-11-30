import Foundation

class SaveSchedule {
    
    private weak var localDataSource: ScheduleLocalDataSource?
    
    init(localDataSource: ScheduleLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func save(schedule: Schedule, _ scheduleCallBack: @escaping (BaseCallback<Bool>) -> Void) {
        localDataSource?.save(schedule: schedule, { (callback) in
            callback.onSuccess({ (success) in
                let callbackSuccess = BaseCallback.success(success)
                scheduleCallBack(callbackSuccess)
            })
            
            callback.onFailed({ (error) in
                let callbackFailed = BaseCallback<Bool>.failed(error: error)
                scheduleCallBack(callbackFailed)
            })
        })
        
    }
    
}
