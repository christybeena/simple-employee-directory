//
//  EmployeeListViewController.swift
//  Simple Employee Directory
//
//  Created by Wildherbs on 04/12/21.
//

import UIKit
import CoreData
import Kingfisher

class EmployeeListViewController: UIViewController {

    @IBOutlet weak var employeeListTableView: UITableView!
    
    var EmployeeListVM = EmployeeListViewModel()


    override func viewDidLoad() {
        
        super.viewDidLoad()
        EmployeeListVM.delegate = self

        
       
        employeeListTableView.register(EmployeeTableViewCell.nib, forCellReuseIdentifier: EmployeeTableViewCell.identifier)
        getEmployeeListAndReloadTV()
 
       
    }
    
   
    
    
    func getEmployeeListAndReloadTV(){
        
    
        
        EmployeeListVM.getEmployeeListFromCoreData{ [unowned self] in
            
//            self.employeeListTableView.reloadData()
            
            if EmployeeListVM.employeeList.count == 0{
                EmployeeListVM.fetchEmployeeListFromService(of: "5d565297300000680030a986")
            }else{
                self.employeeListTableView.reloadData()

            }
            

        }
    
    }
}


// MARK:-fetch data

extension EmployeeListViewController : EmployeeFetchedFromServiceProtocol{
    func fetchedResults(isCompleted: Bool) {
        if EmployeeListVM.employeeList.count>0{
            employeeListTableView.reloadData()

        }
    }
    
    
}



// MARK:-Tableview datasource methods


extension EmployeeListViewController: UITableViewDataSource{
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeListVM.employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let empCell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.identifier, for: indexPath) as? EmployeeTableViewCell,let employee = EmployeeListVM.employeeList[indexPath.row] as? Employee{
            empCell.lblName.text = employee.name
            empCell.lblCompanyName.text = employee.company?.name
            
            if let imageURLString = employee.profileImage,let url = URL(string: imageURLString){
                empCell.imgProfilePhoto.kf.setImage(with: url)

            }
            cell = empCell

        }
        
        return cell
    }
    
    
}


// MARK:-Tableview delegate sourse methods

extension EmployeeListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let employee = EmployeeListVM.employeeList[indexPath.row] as? Employee{
            EmployeeListVM.selectedEmployee = employee
            performSegue(withIdentifier: "goToDetail", sender: self)

            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail"{
            if let DestinationVC = segue.destination as? DetailEmployeeViewController,let selectedEmployee = EmployeeListVM.selectedEmployee{
                DestinationVC.employee = selectedEmployee
            }
        }
    }
}


extension EmployeeListViewController : UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Employee> = Employee.fetchRequest()
        
        let namePredicate = NSPredicate(format: "name CONTAINS[CD] %@", searchBar.text!)
        
        let emailPredicate = NSPredicate(format: "email CONTAINS[CD] %@", searchBar.text!)
        
        let orPredicate = NSCompoundPredicate(type: .or, subpredicates: [namePredicate, emailPredicate])
        
        request.predicate = orPredicate
        
        self.EmployeeListVM.getEmployeeListFromCoreData(with: request) {
            self.employeeListTableView.reloadData()
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0{
            self.getEmployeeListAndReloadTV()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }


}
