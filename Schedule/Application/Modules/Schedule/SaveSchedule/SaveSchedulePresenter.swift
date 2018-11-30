//
//  SaveSchedulePresenter.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import CoreData

class SaveSchedulePresenter: SaveSchedulePresenterContract {
   
    private let view: SaveScheduleViewContract
    private let context: NSManagedObjectContext
    private let getUserSessionUseCase: GetUserSession
    private let saveScheduleUseCase: SaveSchedule

    init(view: SaveScheduleViewContract, context: NSManagedObjectContext, getUserSession: GetUserSession, saveSchedule: SaveSchedule) {
        self.view                  = view
        self.context               = context
        self.getUserSessionUseCase = getUserSession
        self.saveScheduleUseCase   = saveSchedule
    }
    
    func save(title: String, shortDescription: String, detail: String, author: User) {
        let schedule = Schedule(context: context)
        schedule.title = title
        schedule.briefDescription = shortDescription
        schedule.detail = detail
        schedule.user = author
        schedule.isOpen = true
        
        self.saveScheduleUseCase.save(schedule: schedule) { (callback) in
            callback.onSuccess({ (_) in
                self.view.didSaveSuccess()
            })
            callback.onFailed({ (error) in
                if let error = error {
                    self.view.didRegisterError(message: error as? String ?? "Error")
                }
            })
        }
    }
    
    func getUserSession() {
        let user = getUserSessionUseCase.getUserSession(context: context)
       self.view.showUserSession(user: user)
    }
    
}
