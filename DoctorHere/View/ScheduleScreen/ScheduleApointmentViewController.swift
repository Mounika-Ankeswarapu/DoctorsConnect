//
//  ScheduleApointmentViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 19/02/25.
//

import UIKit
import FSCalendar

class ScheduleApointmentViewController: UIViewController {

    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var topDateDisplaylbl: UILabel!
    @IBOutlet weak var scheduleTV: UITableView!
    @IBOutlet weak var bookBtn: UIButton!
    
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var selectedDate: String = ""
    var selectedTime: String?
    var selectedTitle: String?
    let nameLbl = UILabel()
  //  private var calendarHeightConstraint: NSLayoutConstraint!
    
    private var isCalendarVisible = true
    
    let schedules: [Schedule] = [
        Schedule(time: "09:00 AM", title: "Consultation", color: .pastel1),
        Schedule(time: "10:00 AM", title: "Control", color: .pastel2),
        Schedule(time: "10:30 AM", title: "Blood analysis", color: .pastel3),
        Schedule(time: "11:00 AM", title: "General Consultation", color: .pastel4),
        Schedule(time: "01:00 PM", title: "Control", color: .pastel5),
        Schedule(time: "02:00 PM", title: "Physical Consultation", color: .pastel6)
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendar()
        cellRegister()
        updateUI()
    }
    
    func updateUI(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        selectedDate = dateFormatter.string(from: Date())
        topDateDisplaylbl.text = "     " + selectedDate
        
        scheduleTV.isHidden = true
    }
    
    func setUpCalendar(){
        calenderView.delegate = self
        calenderView.dataSource = self
        calenderView.scope = .month
        calenderView.scrollDirection = .horizontal
        calendarHeightConstraint = calenderView.heightAnchor.constraint(equalToConstant: 300)
        calendarHeightConstraint.isActive = true
    }
    
    func updateCalendarView(scope: FSCalendarScope) {
        calenderView.setScope(scope, animated: true)
        calendarHeightConstraint.constant = (scope == .week) ? 300 : 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    func cellRegister(){
        scheduleTV.dataSource = self
        scheduleTV.delegate = self
        scheduleTV.register(UINib(nibName: "ScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "ScheduleTableViewCell")
    }
    
    @IBAction func topBackBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func bookBtnAction(_ sender: UIButton) {
        guard let time = selectedTime, let title = selectedTitle else {
            showAlert(message: "Please select a time slot before booking.")
            return
        }
        
        // Save the selected date and time in UserDefaults
        UserDefaults.standard.set(selectedDate, forKey: "SelectedDate")
        UserDefaults.standard.set(selectedTime, forKey: "SelectedTime")
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homePage = mainStoryboard.instantiateViewController(withIdentifier: "SuccessBookingViewController") as! SuccessBookingViewController
        homePage.selectedDate = selectedDate
        homePage.selectedTime = time
        homePage.selectedTitle = title
        self.navigationController?.pushViewController(homePage, animated: true)
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - FSCalendar Delegate & DataSource
extension ScheduleApointmentViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        filterEvents(for: date)
    }
    
    func filterEvents(for date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        selectedDate = dateFormatter.string(from: date)
        
        topDateDisplaylbl.text = "     " + selectedDate
        
        // Show scheduleTV and switch calendar to week view
        scheduleTV.isHidden = false
        //calenderView.setScope(.week, animated: true)
        updateCalendarView(scope: .week)
        scheduleTV.reloadData()
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
            return Date() // Disable selection of past dates
    }
}

// MARK: - UITableView Delegate & DataSource
extension ScheduleApointmentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scheduleTV.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        cell.selectionStyle = .blue
        let schedule = schedules[indexPath.row]
        cell.timeLbl.text = schedule.time
        cell.titleLbl.text = schedule.title
        cell.titleBgView.backgroundColor = schedule.color
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTime = schedules[indexPath.row].time
        selectedTitle = schedules[indexPath.row].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - Schedule Model
struct Schedule {
    let time: String
    let title: String
    let color: UIColor
}




