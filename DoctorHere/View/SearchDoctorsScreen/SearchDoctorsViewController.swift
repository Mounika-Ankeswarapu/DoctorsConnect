//
//  SearchDoctorsViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 19/02/25.
//

import UIKit

class SearchDoctorsViewController: UIViewController {
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var docCategoryCV: UICollectionView!
    @IBOutlet weak var doctorsTV: UITableView!
    @IBOutlet weak var docFoundLbl: UILabel!
    
    var allDoctors: [DoctorWithSpecialization] = []
    var filteredDoctors: [DoctorWithSpecialization] = []

    let docType: [DocType] = [
        DocType(img: UIImage.heart, title: "Cardiologist"),
        DocType(img: UIImage.neuroDoc, title: "Neurologist"),
        DocType(img: UIImage.dentist, title: "Dentist"),
        DocType(img: .checkmark, title: "title")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegister()
        updateUI()
        loadDoctorsFromJSON()
    }
    
    func updateUI() {
        searchView.layer.cornerRadius = 12
        //docFoundLbl.text = "\(docType.count) Doctors found"
    }
    
    func cellRegister() {
        docCategoryCV.delegate = self
        docCategoryCV.dataSource = self
        docCategoryCV.register(UINib(nibName: "DocCategoryCVC", bundle: nil), forCellWithReuseIdentifier: "DocCategoryCVC")
        
        doctorsTV.delegate = self
        doctorsTV.dataSource = self
        doctorsTV.register(UINib(nibName: "TopDoctorListTVC", bundle: nil), forCellReuseIdentifier: "TopDoctorListTVC")
    }
    
    func loadDoctorsFromJSON() {
        if let path = Bundle.main.path(forResource: "DoctorsData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedData = try JSONDecoder().decode(DoctorData.self, from: data)

                // Assign specialization while decoding
                allDoctors = decodedData.doctors.flatMap { category in
                    category.doctors.map { doctor in
                        DoctorWithSpecialization(name: doctor.name, specialization: category.specialization, rating: doctor.rating, img: doctor.img, location: doctor.location)
                    }
                }

                filteredDoctors = allDoctors // Initially show all doctors
                self.docFoundLbl.text = "\(allDoctors.count) Doctors Found"
                print("✅ Doctors loaded successfully: \(allDoctors.count)")
                doctorsTV.reloadData()
            } catch {
                print("❌ Error decoding JSON: \(error)")
            }
        } else {
            print("❌ JSON file not found!")
        }
    }



    
    @IBAction func topBackBtnAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchDoctorsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return docType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = docCategoryCV.dequeueReusableCell(withReuseIdentifier: "DocCategoryCVC", for: indexPath) as! DocCategoryCVC
        let category = docType[indexPath.row]
        cell.categoryImg.image = category.img
        cell.categoryLbl.text = category.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = docType[indexPath.row].title
        filteredDoctors = allDoctors.filter { $0.specialization == selectedCategory }
        
        print("Selected category: \(selectedCategory)")
        print("Filtered Doctors Count: \(filteredDoctors.count)")
        docFoundLbl.text = "\(filteredDoctors.count) Doctors found"
        doctorsTV.reloadData()
    }

}

extension SearchDoctorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDoctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorsTV.dequeueReusableCell(withIdentifier: "TopDoctorListTVC", for: indexPath) as! TopDoctorListTVC
        cell.selectionStyle = .none
        let doctor = filteredDoctors[indexPath.row]
        
        cell.docNameLbl.text = doctor.name
        cell.docSpecificationLbl.text = doctor.specialization
        cell.numOfReviewsLbl.text = "Rating: \(doctor.rating)"
        cell.starRatingView.value = CGFloat(doctor.rating)

        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        if let scheduleVC = mainStoryBoard.instantiateViewController(withIdentifier: "ScheduleApointmentViewController") as? ScheduleApointmentViewController {
            self.navigationController?.pushViewController(scheduleVC, animated: true)
        }
    }
}

// MARK: - Models
struct DocType {
    let img: UIImage
    let title: String
}

struct DoctorData: Codable {
    let doctors: [DoctorCategory]
}

struct DoctorCategory: Codable {
    let specialization: String
    let doctors: [Doctor]
}

struct Doctor: Codable {
    let name: String
    //let specialization: String
    let rating: Double
    let img: String
    let location: String
}

struct DoctorWithSpecialization {
    let name: String
    let specialization: String
    let rating: Double
    let img: String
    let location: String
}
