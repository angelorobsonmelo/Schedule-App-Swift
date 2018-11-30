import CoreData

public class ScheduleLocalDataSourceImpl: ScheduleLocalDataSource {
    
    public static let shared = ScheduleLocalDataSourceImpl()
    
    public func save(schedule: Schedule, _ apiAuthCallback: @escaping (BaseCallback<Bool>) -> Void) {
        do {
            try schedule.managedObjectContext?.save()
            let callbackSuccess = BaseCallback.success(true)
            apiAuthCallback(callbackSuccess)
        } catch {
            print(error.localizedDescription)
            let callbackFailed = BaseCallback<Bool>.failed(error: error.localizedDescription)
            apiAuthCallback(callbackFailed)
        }
    }
    
    public func getSchedulesOpeneds(context: NSManagedObjectContext, _ apiAuthCallback: @escaping (BaseCallback<[Schedule]>) -> Void) {
        let fetchRequet: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        fetchRequet.predicate = NSPredicate(format: "isOpen = %@", NSNumber(value: true))
        fetchRequet.sortDescriptors = [NSSortDescriptor.init(key: "title", ascending: true)]
        
        do {
            let schedules = try context.fetch(fetchRequet)
            let callbackSuccess = BaseCallback.success(schedules)
            apiAuthCallback(callbackSuccess)
     
        } catch {
            print(error.localizedDescription)
            let callbackFailed = BaseCallback<[Schedule]>.failed(error: error.localizedDescription)
            apiAuthCallback(callbackFailed)
        }

    }
    
    public func getSchedulesCloseds(context: NSManagedObjectContext, _ apiAuthCallback: @escaping (BaseCallback<[Schedule]>) -> Void) {
        let fetchRequet: NSFetchRequest<Schedule> = Schedule.fetchRequest()
        fetchRequet.predicate = NSPredicate(format: "isOpen = %@", NSNumber(value: false))
        
        do {
            let schedules = try context.fetch(fetchRequet)
            let callbackSuccess = BaseCallback.success(schedules)
            apiAuthCallback(callbackSuccess)
            
        } catch {
            print(error.localizedDescription)
            let callbackFailed = BaseCallback<[Schedule]>.failed(error: error.localizedDescription)
            apiAuthCallback(callbackFailed)
        }
    }
    
}
