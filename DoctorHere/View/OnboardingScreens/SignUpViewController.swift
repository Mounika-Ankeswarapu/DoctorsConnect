//
//  SignUpViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 18/02/25.
//

import UIKit
import CoreData

class SignUpViewController: ViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var mobileNumTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func registerBtnAction(_ sender: UIButton) {
        
        guard let name = nameTF.text, !name.isEmpty,
              let password = passwordTF.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTF.text, !confirmPassword.isEmpty,
              let mobileNumber = mobileNumTF.text, !mobileNumber.isEmpty,
              let location = locationTF.text, !location.isEmpty else {
            showAlert(message: "All fields are required.", delay: 0)
            return
        }
        
        if password != confirmPassword {
            showAlert(message: "Passwords do not match.", delay: 0)
            return
        }
        
        saveUserToCoreData(name: name, password: password, mobileNumber: mobileNumber, location: location)
    }
    
    func saveUserToCoreData(name: String, password: String, mobileNumber: String, location: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        guard NSEntityDescription.entity(forEntityName: "User", in: context) != nil else {
            print("Failed to find User entity")
            return
        }
        
        let newUser = User(context: context)
        newUser.name = name
        newUser.password = password
        newUser.mobileNumber = mobileNumber
        newUser.location = location
        
        do {
            try context.save()
            showAlert(message: "Registration successful!", delay: 3)
        } catch {
            showAlert(message: "Failed to save user: \(error.localizedDescription)", delay: 0)
        }
    }

    func showAlert(message: String, delay: TimeInterval) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            alert.dismiss(animated: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
}
