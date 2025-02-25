//
//  ScheduleTableViewCell.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 20/02/25.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var titleBgView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleBgView.layer.cornerRadius = 12
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(time: String, title: String, color: UIColor) {
        timeLbl.text = time
        titleLbl.text = title
        titleBgView.backgroundColor = color.withAlphaComponent(0.3)
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.systemBlue.withAlphaComponent(0.2) : UIColor.clear
            layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
            layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
}
