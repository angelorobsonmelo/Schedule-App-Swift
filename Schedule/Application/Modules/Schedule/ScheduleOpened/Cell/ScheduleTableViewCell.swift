//
//  ScheduleTableViewCell.swift
//  Schedule
//
//  Created by Ângelo Melo on 29/11/18.
//  Copyright © 2018 Ângelo Melo. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    public static let identifier = "cellExpanded"

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    @IBOutlet weak var detailsHeigh: NSLayoutConstraint!
    @IBOutlet weak var viewMain: UIView!

    var isExpanded: Bool = false {
        didSet {
            if !isExpanded {
                self.detailsHeigh.constant = 0.0
                
            } else {
                self.detailsHeigh.constant = 123.0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
