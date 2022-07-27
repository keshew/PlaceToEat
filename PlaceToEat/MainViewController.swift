//
//  MainViewController.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 27.07.2022.
//

import UIKit

class MainViewController: UITableViewController {

    var cafeTest = ["TramCafe","yChurki"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cafeTest.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.imageView?.image = UIImage(named: cafeTest[indexPath.row])
        cell.textLabel?.text = cafeTest[indexPath.row]
        cell.imageView?.layer.cornerRadius = cell.frame.size.height / 2 
        cell.imageView?.clipsToBounds = true
        
        return cell
    }
    
    // MARK: TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
