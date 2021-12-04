//
//  DetailEmployeeViewController.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//

import UIKit
import CoreData
import Kingfisher

class DetailEmployeeViewController: UIViewController {
    var employee : Employee?
    
    @IBOutlet weak var imgprofile: UIImageView!{
        didSet{
            imgprofile.layer.cornerRadius = imgprofile.bounds.width/2
            imgprofile.layer.borderColor = UIColor.black.cgColor
            imgprofile.layer.borderWidth = 2

        }
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblNEmailId: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblCompanyDetails: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
   
    }
    func loadData(){
        
        if let imageURLString = employee?.profileImage,let url = URL(string: imageURLString){
            self.imgprofile.kf.setImage(with: url)
        }
        lblName.text = employee?.name ?? "Not Available"
        lblUserName.text = employee?.username ?? "Not Available"
        lblNEmailId.text = employee?.email ?? "Not Available"
        lblAddress.text = "\(employee?.address?.street ?? ""),\(employee?.address?.suite ?? "") "
        lblPhone.text = employee?.phone ?? "Not Available"
        lblWebsite.text = employee?.website ?? "Not Available"
        lblCompanyDetails.text = employee?.company?.name ?? "Not Available"

    }
    
}
