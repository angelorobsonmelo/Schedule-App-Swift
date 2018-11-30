import Foundation
import CoreData

public protocol ScheduleLocalDataSource: class {
    
    func save(schedule: Schedule, _ apiAuthCallback: @escaping (BaseCallback<Bool>) -> Void)
    func getSchedulesOpeneds(context: NSManagedObjectContext, _ apiAuthCallback: @escaping (BaseCallback<[Schedule]>) -> Void)
    func getSchedulesCloseds(context: NSManagedObjectContext, _ apiAuthCallback: @escaping (BaseCallback<[Schedule]>) -> Void)

}
