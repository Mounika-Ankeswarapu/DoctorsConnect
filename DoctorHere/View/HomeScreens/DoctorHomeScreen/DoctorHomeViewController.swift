//
//  DoctorHomeViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 18/02/25.
//

import UIKit
import CoreData

class DoctorHomeViewController: ViewController {

    @IBOutlet weak var appointmentView: UIView!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var patientNameLbl: UILabel!
    @IBOutlet weak var patientLocationLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var appointmentListTV: UITableView!
    
    let appointmentDetails: [AppointmentModel] = [
        AppointmentModel(name: "John Doe", time: "17 June 2025, 09:00 AM", color: .pastel1),
        AppointmentModel(name: "Daisy", time: "18 June 2025, 10:30 AM", color: .pastel2),
        AppointmentModel(name: "Harry", time: "19 June 2025, 11:00 AM", color: .pastel3),
        AppointmentModel(name: "Jane", time: "20 June 2025, 09:00 AM", color: .pastel4),
        AppointmentModel(name: "Dave", time: "21 June 2025, 09:00 AM", color: .pastel5),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellRegister()
        
        // Retrieve saved date and time
        let selectedDate = UserDefaults.standard.string(forKey: "SelectedDate") ?? "16 June 2020"
        let selectedTime = UserDefaults.standard.string(forKey: "SelectedTime") ?? "10:30 AM"
        
        dateAndTimeLbl.text = "\(selectedDate),\(selectedTime)"
 
        
        // Retrieve logged-in user details
           let loggedInUserName = UserDefaults.standard.string(forKey: "LoggedInUserName") ?? "Unknown"
           let loggedInUserLocation = UserDefaults.standard.string(forKey: "LoggedInUserLocation") ?? "Not Available"
           
           // Set the name and location
           patientNameLbl.text = loggedInUserName
           patientLocationLbl.text = loggedInUserLocation
    }

    
    func cellRegister(){
        appointmentListTV.delegate = self
        appointmentListTV.dataSource = self
        appointmentListTV.register(UINib(nibName: "AppointmentListTVC", bundle: nil), forCellReuseIdentifier: "AppointmentListTVC")
    }
    

    @IBAction func acceptBtnAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Doctors", bundle: nil)
        let doctorHomePage = mainStoryboard.instantiateViewController(withIdentifier: "SuccessPageViewController") as! SuccessPageViewController
        self.navigationController?.pushViewController(doctorHomePage, animated: true)
        
    }
    
    @IBAction func declineBtnAction(_ sender: Any) {
        let mainStoryboard = UIStoryboard(name: "Doctors", bundle: nil)
        let doctorHomePage = mainStoryboard.instantiateViewController(withIdentifier: "FailurePageViewController") as! FailurePageViewController
        self.navigationController?.pushViewController(doctorHomePage, animated: true)
    }
}

extension DoctorHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appointmentListTV.dequeueReusableCell(withIdentifier: "AppointmentListTVC", for: indexPath) as! AppointmentListTVC
        cell.selectionStyle = .blue
        let data = appointmentDetails[indexPath.row]
        cell.profileView.layer.backgroundColor = data.color.cgColor
        cell.patientNameLbl.text = data.name
        cell.appointTimeLbl.text = data.time
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAppointment = appointmentDetails[indexPath.row]
        
        print("Selected Name: \(selectedAppointment.name)")
        print("Selected Time: \(selectedAppointment.time)")
        
        DispatchQueue.main.async { [weak self] in
            self?.dateAndTimeLbl.text = selectedAppointment.time
            self?.patientNameLbl.text = selectedAppointment.name
        }
    }

    
    
}


// MARK: - Schedule Model
struct AppointmentModel {
    let name: String
    let time: String
    let color: UIColor
}

