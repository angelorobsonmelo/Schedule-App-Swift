//
//  SaveSchedulePresenter.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import CoreData

class ScheduleClosedPresenter: ScheduleClosedPresenterContract {
    
    private let view: ScheduleClosedViewContract
    private let context: NSManagedObjectContext
    private let destroySessionUseCase: DestroySession
    private let getSchedulesClosedsUseCase: GetSchedulesCloseds
    private let saveScheduleUseCase: SaveSchedule
    
    init(view: ScheduleClosedViewContract, context: NSManagedObjectContext,
         destroySession: DestroySession, getSchedules: GetSchedulesCloseds, saveSchedule: SaveSchedule) {
        self.view                  = view
        self.context               = context
        self.destroySessionUseCase = destroySession
        self.getSchedulesClosedsUseCase = getSchedules
        self.saveScheduleUseCase = saveSchedule
    }
    
    func getSchedulesCloseds() {
        getSchedulesClosedsUseCase.getSchedules(context: context) { (callback) in
            callback.onSuccess({ (schedules) in
                self.view.showSchedulesCloseds(schedues: schedules)
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
    
    func reopen(schedule: Schedule) {
        schedule.isOpen = true
        self.saveScheduleUseCase.save(schedule: schedule) { (callback) in
            callback.onSuccess({ (_) in
                self.view.reopenSuccessfully()
            })
            callback.onFailed({ (error) in
                if let error = error {
                    self.view.didSchedulesError(message: error as? String ?? "Error")
                }
            })
        }
    }
    
}
