//
//  SaveSchedulePresenter.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import CoreData

class ScheduleOpenedPresenter: ScheduleOpenedPresenterContract {
    
    private let view: ScheduleOpenedViewContract
    private let context: NSManagedObjectContext
    private let destroySessionUseCase: DestroySession
    private let getSchedulesOpenedsUseCase: GetSchedulesOpeneds
    private let saveScheduleUseCase: SaveSchedule
    
    init(view: ScheduleOpenedViewContract, context: NSManagedObjectContext,
         destroySession: DestroySession, getSchedules: GetSchedulesOpeneds, saveSchedule: SaveSchedule) {
        self.view                  = view
        self.context               = context
        self.destroySessionUseCase = destroySession
        self.getSchedulesOpenedsUseCase = getSchedules
        self.saveScheduleUseCase = saveSchedule
    }
    
    func getSchedulesOpeneds() {
        getSchedulesOpenedsUseCase.getSchedules(context: context) { (callback) in
            callback.onSuccess({ (schedules) in
                self.view.showSchedulesOpeneds(schedues: schedules)
            })
            callback.onFailed({ (error) in
                if let error = error {
                   self.view.didSchedulesError(message: error as? String ?? "Error")
                }
            })
        }
    }
    
    func destroySession() {
        if destroySessionUseCase.destroySession() {
            self.view.didDestroySessionSuccess()
        } else {
            self.view.didSchedulesError(message: "Error in logout")
        }
    }
    
    func close(schedule: Schedule) {
        schedule.isOpen = false
        self.saveScheduleUseCase.save(schedule: schedule) { (callback) in
            callback.onSuccess({ (_) in
                self.view.closeSuccessfully()
            })
            callback.onFailed({ (error) in
                if let error = error {
                    self.view.didSchedulesError(message: error as? String ?? "Error")
                }
            })
        }
    }

}
