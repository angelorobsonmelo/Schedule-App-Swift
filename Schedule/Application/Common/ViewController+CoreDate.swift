//
//  ViewController+CoreDate.swift
//  Schedule
//
//  Created by Ângelo Melo on 28/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return (appDelegate?.persistentContainer.viewContext)!
    }
    
}
