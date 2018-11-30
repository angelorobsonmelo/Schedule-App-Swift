//
//  ScheduleTableViewController.swift
//  Schedule
//
//  Created by Ângelo Melo on 28/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit
import CoreData

class ScheduleOpenedTableViewController: UITableViewController, ScheduleOpenedViewContract {
    
    var schedulesOpeneds = [Schedule]()
    var label = UILabel()
    var expandedRows = Set<Int>()
    
    lazy var presenter: ScheduleOpenedPresenterContract = {
        return ScheduleOpenedPresenter(view: self,
                                       context: context,
                                       destroySession: InjectionUseCase.provideDestroySession(),
                                       getSchedules: InjectionUseCase.provideGetSchedulesOpeneds(),
                                       saveSchedule: InjectionUseCase.provideSaveSchedule())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "There are no registered schedules"
        label.textAlignment = .center
        tableView.backgroundView = label
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getSchedulesOpeneds()
    }
    
    func showSchedulesOpeneds(schedues: [Schedule]) {
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
        return 218
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = schedulesOpeneds.count
        tableView.backgroundView = count == 0 ? label : nil
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.identifier, for: indexPath) as? ScheduleTableViewCell ?? ScheduleTableViewCell()
        let index = indexPath.row
        let schedule = schedulesOpeneds[index]
        cell.selectionStyle = .none
        cell.populateCell(schedule: schedule)
        cell.closeButton.tag = index
        cell.closeButton.addTarget(self, action: #selector(ScheduleOpenedTableViewController.close), for: .touchUpInside)
        cell.isExpanded = self.expandedRows.contains(indexPath.row)
        
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let cell = tableView.cellForRow(at: indexPath) as? ScheduleTableViewCell
            else { return }
        
        switch cell.isExpanded {
        case true:
            self.expandedRows.remove(indexPath.row)
        case false:
            self.expandedRows.insert(indexPath.row)
        }
    
        cell.isExpanded = !cell.isExpanded
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
    }
    
   override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ScheduleTableViewCell
            else { return }
        
        self.expandedRows.remove(indexPath.row)
        
        cell.isExpanded = false
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
    }
    
    @objc func close(sender: UIButton) {
        let index = sender.tag
        let schedule = schedulesOpeneds[index]
        
        let alertClose = UIAlertController(title: "Alert",
                                           message: "Do you want to close schedule \(schedule.title!)?",
                                            preferredStyle: .alert)
        
        let buttonCloseAction = UIAlertAction(title: "Close", style: .default, handler: { _ in
            self.presenter.close(schedule: schedule)
        })
        
        let buttonCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            return
        })
        
        alertClose.addAction(buttonCloseAction)
        alertClose.addAction(buttonCancelAction)
        
        self.present(alertClose, animated: true, completion: nil)
    }
    
    func closeSuccessfully() {
        self.presentAlert(message: "closeSuccessfully")
        presenter.getSchedulesOpeneds()
    }
    
}
