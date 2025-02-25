//
//  PatientHomeViewController.swift
//  DoctorHere
//
//  Created by Mounika Ankeswarapu on 18/02/25.
//

import UIKit

class PatientHomeViewController: ViewController {

    @IBOutlet weak var doctorProfileCV: UICollectionView!
    @IBOutlet weak var adviceCV: UICollectionView!
    @IBOutlet weak var doctorsListTV: UITableView!
    
    let adviceData: [AdviceModel] = [
        AdviceModel(adviceImg: UIImage.heartt, adviceName: "Love YourSelf"),
        AdviceModel(adviceImg: UIImage.supportIcon, adviceName: "Do Support"),
        AdviceModel(adviceImg: UIImage.eatHealthy, adviceName: "Eat Healthy"),
        
    ]
    
    let doctorsData: [DoctorsModel] = [
        DoctorsModel(name: "Dr. John Smith", category: "Cardiologist", rating:  4.8, profileViewBgColor: .pastel1),
        DoctorsModel(name: "Dr. James Miller", category: "Neurologist", rating:  4.7, profileViewBgColor: .pastel2),
        DoctorsModel(name: "Dr. Sarah Johnson", category: "Cardiologist", rating:  4.6, profileViewBgColor: .pastel3),
        DoctorsModel(name: "Dr. Robert Wilson", category: "Dentist", rating:  4.8, profileViewBgColor: .pastel4),
        DoctorsModel(name: "Dr. Olivia White", category: "Neurologist", rating:  4.7, profileViewBgColor: .pastel5),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellRegister()
    }
    
    func cellRegister(){
        
        doctorProfileCV.delegate = self
        doctorProfileCV.dataSource = self

        doctorProfileCV.register(UINib(nibName: "doctorProfileCardCVC", bundle: nil), forCellWithReuseIdentifier: "doctorProfileCardCVC")
        
        adviceCV.delegate = self
        adviceCV.dataSource = self
        adviceCV.register(UINib(nibName: "AdviceCardCVC", bundle: nil), forCellWithReuseIdentifier: "AdviceCardCVC")
        
        doctorsListTV.delegate = self
        doctorsListTV.dataSource = self
        doctorsListTV.register(UINib(nibName: "TopDoctorListTVC", bundle: nil), forCellReuseIdentifier: "TopDoctorListTVC")
        
    }
    
    @IBAction func topSearchBtnAction(_ sender: UIButton) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = mainStoryBoard.instantiateViewController(withIdentifier: "SearchDoctorsViewController") as! SearchDoctorsViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
   
}

extension PatientHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == doctorProfileCV {
            
            return doctorsData.count
        }else{
            return adviceData.count
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == doctorProfileCV {
            let cell = doctorProfileCV.dequeueReusableCell(withReuseIdentifier: "doctorProfileCardCVC", for: indexPath) as! doctorProfileCardCVC
            let data = doctorsData[indexPath.row]
            
            cell.nameLbl.text = data.name
            cell.specialityLbl.text = data.category
            cell.ratingLbl.text = "\(data.rating)"
            
            return cell
        }else{
            let cell = adviceCV.dequeueReusableCell(withReuseIdentifier: "AdviceCardCVC", for: indexPath) as! AdviceCardCVC
            let data = adviceData[indexPath.row]
           // cell.nameLbl.text = "John Doe"
            cell.adviceImg.image = data.adviceImg
            cell.adviceNameLbl.text = data.adviceName
            
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.size.width - 50
        let cellHeight: CGFloat = collectionView.frame.size.height
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

extension PatientHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = doctorsListTV.dequeueReusableCell(withIdentifier: "TopDoctorListTVC", for: indexPath) as! TopDoctorListTVC
        cell.selectionStyle = .none
        let data = doctorsData[indexPath.row]
        cell.docNameLbl.text = data.name
        cell.docSpecificationLbl.text = data.category
        cell.numOfReviewsLbl.text = "(\(data.rating) reviews)"
        cell.imgView.backgroundColor = data.profileViewBgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = mainStoryBoard.instantiateViewController(withIdentifier: "SearchDoctorsViewController") as! SearchDoctorsViewController
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
    
    
    
}


// MARK: - Models
struct AdviceModel {
    let adviceImg: UIImage
    let adviceName: String
}

struct DoctorsModel {
    let name: String
    let category: String
    let rating: Double
    let profileViewBgColor: UIColor
}

