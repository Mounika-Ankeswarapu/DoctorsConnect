//
//  DocCategoryCVC.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 19/02/25.
//

import UIKit

class DocCategoryCVC: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.layer.cornerRadius = 14
    }
    override var isSelected: Bool {
            didSet {
                contentView.backgroundColor = isSelected ? UIColor.systemBlue.withAlphaComponent(0.2) : UIColor.clear
                layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.clear.cgColor
                layer.borderWidth = isSelected ? 2 : 0
            }
        }
}
