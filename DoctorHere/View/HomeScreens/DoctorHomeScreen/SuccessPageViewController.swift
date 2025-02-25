//
//  SuccessPageViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 20/02/25.
//

import UIKit

class SuccessPageViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popUpView.layer.cornerRadius = 15
    }
    

    @IBAction func topBackBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(homePage, animated: true)
    }
}
