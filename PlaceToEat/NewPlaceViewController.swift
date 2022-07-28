//
//  NewPlaceViewController.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 28.07.2022.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
     
    }
    
    //MARK: TableView delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
    //MARK: - TextField delegate
    
    extension NewPlaceViewController: UITextFieldDelegate {
        
        //hide keyboard by tap on "DONE"
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        
    }
    
    
    

