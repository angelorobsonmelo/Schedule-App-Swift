import Foundation

class InjectionUseCase {
    
    private static let sessionRemoteDataSource = InjectionLocalDataSource.provideSessionDataSource()
    private static let registerLocalDataSource = InjectionLocalDataSource.provideRegisterDataSource()
    private static let scheduleLocalDataSource = InjectionLocalDataSource.provideScheduleDataSource()

    static func provideRegister() -> Register {
      return Register(localDataSource: registerLocalDataSource)
    }
    
    static func provideGetUserSession() -> GetUserSession {
        return GetUserSession(localDataSource: sessionRemoteDataSource)
    }
    
    static func provideGetToken() -> GetToken {
        return GetToken(localDataSource: sessionRemoteDataSource)
    }
    
    static func provideSaveSession() -> SaveSession {
        return SaveSession(localDataSource: sessionRemoteDataSource)
    }
    
    static func provideDestroySession() -> DestroySession {
        return DestroySession(localDataSource: sessionRemoteDataSource)
    }
    
    static func provideSaveSchedule() -> SaveSchedule {
        return SaveSchedule(localDataSource: scheduleLocalDataSource)
    }
    
    static func provideGetSchedulesOpeneds() -> GetSchedulesOpeneds {
        return GetSchedulesOpeneds(localDataSource: scheduleLocalDataSource)
    }
    
    static func provideGetSchedulesCloseds() -> GetSchedulesCloseds {
        return GetSchedulesCloseds(localDataSource: scheduleLocalDataSource)
    }
    
}
