//
//  adviceCardCVC.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 18/02/25.
//

import UIKit

class AdviceCardCVC: UICollectionViewCell {
    

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var adviceImg: UIImageView!
    
    @IBOutlet weak var adviceNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 15
    }
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? UIColor.systemBlue.withAlphaComponent(0.2) : UIColor.clear
                layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
                layer.borderWidth = isSelected ? 2 : 0
            }
        }

}
