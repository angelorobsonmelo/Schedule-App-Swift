//
//  ScheduleTableViewController.swift
//  Schedule
//
//  Created by Ângelo Melo on 28/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit
import CoreData

class ScheduleClosedTableViewController: UITableViewController, ScheduleClosedViewContract {
    
    var schedulesOpeneds = [Schedule]()
    var label = UILabel()
    
    lazy var presenter: ScheduleClosedPresenterContract = {
        return ScheduleClosedPresenter(view: self,
                                       context: context,
                                       destroySession: InjectionUseCase.provideDestroySession(),
                                       getSchedules: InjectionUseCase.provideGetSchedulesCloseds(),
                                       saveSchedule: InjectionUseCase.provideSaveSchedule())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "There are no registered schedules"
        label.textAlignment = .center
        tableView.backgroundView = label
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getSchedulesCloseds()
    }
    
    func showSchedulesCloseds(schedues: [Schedule]) {
        schedulesOpeneds = schedues
        tableView.reloadData()
    }
    
    func didSchedulesError(message: String) {
        self.presentAlertError(message: message)
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        presenter.destroySession()
    }
    
    func didDestroySessionSuccess() {
        goToLoginViewController()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 253
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = schedulesOpeneds.count
        tableView.backgroundView = count == 0 ? label : nil
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "closeCell", for: indexPath) as? ScheduleCloseTableViewCell ?? ScheduleCloseTableViewCell()
        let index = indexPath.row
        let schedule = schedulesOpeneds[index]
        cell.selectionStyle = .none
        cell.populateCell(schedule: schedule)
        cell.reopenButton.tag = index
        cell.reopenButton.addTarget(self, action: #selector(ScheduleClosedTableViewController.reopen), for: .touchUpInside)
        
        return cell
    }
    
    @objc func reopen(sender: UIButton) {
        let index = sender.tag
        let schedule = schedulesOpeneds[index]
        
        let alertOpen = UIAlertController(title: "Alert",
                                           message: "Do you want to reopen schedule \(schedule.title!)?",
            preferredStyle: .alert)
        
        let buttonCloseAction = UIAlertAction(title: "Reopen", style: .default, handler: { _ in
            self.presenter.reopen(schedule: schedule)
        })
        
        let buttonCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            return
        })
        
        alertOpen.addAction(buttonCloseAction)
        alertOpen.addAction(buttonCancelAction)
        
        self.present(alertOpen, animated: true, completion: nil)
    }
    
    func reopenSuccessfully() {
        self.presentAlert(message: "Reopen Successfully")
        presenter.getSchedulesCloseds()
    }
    
}
