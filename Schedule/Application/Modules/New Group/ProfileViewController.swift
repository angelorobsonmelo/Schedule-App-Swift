//
//  ProfileUIViewController.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController, ProfileViewContract {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    lazy var presenter: ProfilePresenterContract = {
        return ProfilePresenter(view: self,
                                context: context,
                                getUserSession: InjectionUseCase.provideGetUserSession(),
                                destroySession: InjectionUseCase.provideDestroySession())
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getUserSession()
        // Do any additional setup after loading the view.
    }
    
    func showUserSession(user: User) {
        nameLabel.text  = user.name
        emailLabel.text = user.email
    }
    
    @IBAction func destroySession(_ sender: UIBarButtonItem) {
        presenter.destroySession()
    }
    
    func didError(message: String) {
        self.presentAlertError(message: message)
    }
    
    func didDestroySessionSuccess() {
        goToLoginViewController()
    }

}
