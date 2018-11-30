//
//  SaveSchedulePresenter.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import CoreData

class ProfilePresenter: ProfilePresenterContract {
 
    private let view: ProfileViewContract
    private let context: NSManagedObjectContext
    private let getUserSessionUseCase: GetUserSession
    private let destroySessionUseCase: DestroySession
    
    init(view: ProfileViewContract, context: NSManagedObjectContext, getUserSession: GetUserSession, destroySession: DestroySession) {
        self.view                  = view
        self.context               = context
        self.getUserSessionUseCase = getUserSession
        self.destroySessionUseCase = destroySession
    }
    
    func destroySession() {
        if destroySessionUseCase.destroySession() {
            self.view.didDestroySessionSuccess()
        } else {
            self.view.didError(message: "Error in logout")
        }
    }
    
    func getUserSession() {
        let user = getUserSessionUseCase.getUserSession(context: context)
        self.view.showUserSession(user: user)
    }
    
}
