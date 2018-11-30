//
//  ScheduleTableViewCell.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit

class ScheduleCloseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reopenButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func populateCell(schedule: Schedule) {
        titleLabel.text = schedule.title
        shortDescriptionLabel.text = schedule.briefDescription
        authorLabel.text = schedule.user?.name
        descriptionLabel.text = schedule.detail
    }
    
}
