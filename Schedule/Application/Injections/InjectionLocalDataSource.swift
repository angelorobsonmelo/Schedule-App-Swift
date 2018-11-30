import Foundation

class InjectionLocalDataSource {
    
    class func provideSessionDataSource() -> SessionLocalDataSource {
        return SessionLocalDataSourceImpl.shared
    }
    
    class func provideRegisterDataSource() -> RegisterLocalDataSource {
        return RegisterLocalDataSourceImpl.shared
    }
    
    class func provideScheduleDataSource() -> ScheduleLocalDataSource {
        return ScheduleLocalDataSourceImpl.shared
    }
    
}
