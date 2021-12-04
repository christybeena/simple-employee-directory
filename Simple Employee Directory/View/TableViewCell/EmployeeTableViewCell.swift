//
//  EmployeeTableViewCell.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfilePhoto: UIImageView!{
        didSet{
            imgProfilePhoto.layer.cornerRadius =  imgProfilePhoto.bounds.width/2
            imgProfilePhoto.layer.borderColor = UIColor.black.cgColor
            imgProfilePhoto.layer.borderWidth = 2

        }
        
    }
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    
  
    class var identifier:String{
        return String(describing: self)
    }
    
    class var nib:UINib{
        return UINib(nibName: identifier, bundle: .main)
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
