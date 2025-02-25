//
//  LoginViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 18/02/25.
//

import UIKit
import CoreData

class LoginViewController: ViewController {
    
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllUsers()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        guard let username = userNameTF.text, !username.isEmpty,
              let password = passwordTF.text, !password.isEmpty else {
            showAlert(message: "Please enter username and password.")
            return
        }
        
        // Check for default doctor credentials
        if username == "doctor" && password == "12345" {
            let mainStoryboard = UIStoryboard(name: "Doctors", bundle: nil)
            let doctorHomePage = mainStoryboard.instantiateViewController(withIdentifier: "DoctorHomeViewController") as! DoctorHomeViewController
            self.navigationController?.pushViewController(doctorHomePage, animated: true)
            return
        }
        
//        if authenticateUser(username: username, password: password) {
//            
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "PatientHomeViewController") as! PatientHomeViewController
//            self.navigationController?.pushViewController(homePage, animated: true)
//        } else {
//            showAlert(message: "Invalid username or password.")
//        }
        if let user = fetchUser(username: username, password: password) {
                // Save user details in UserDefaults
                UserDefaults.standard.set(user.name, forKey: "LoggedInUserName")
                UserDefaults.standard.set(user.location, forKey: "LoggedInUserLocation")
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homePage = mainStoryboard.instantiateViewController(withIdentifier: "PatientHomeViewController") as! PatientHomeViewController
                self.navigationController?.pushViewController(homePage, animated: true)
            } else {
                showAlert(message: "Invalid username or password.")
            }
        
    }
    // Function to fetch user details from CoreData
    func fetchUser(username: String, password: String) -> User? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@ AND password == %@", username, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }
//    func authenticateUser(username: String, password: String) -> Bool {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
//        let context = appDelegate.persistentContainer.viewContext
//        
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "name == %@ AND password == %@", username, password)
//        
//        do {
//            let users = try context.fetch(fetchRequest)
//            return !users.isEmpty
//        } catch {
//            print("Failed to fetch user: \(error.localizedDescription)")
//            return false
//        }
//    }
    func fetchAllUsers() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            print("Total Users: \(users.count)")
            for user in users {
                print("Name: \(user.name ?? ""), Mobile: \(user.mobileNumber ?? ""), Location: \(user.location ?? "")")
            }
        } catch {
            print("Failed to fetch users: \(error.localizedDescription)")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
