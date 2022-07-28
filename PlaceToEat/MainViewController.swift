//
//  MainViewController.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 27.07.2022.
//

import UIKit

class MainViewController: UITableViewController {


    var places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.nameLabel?.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace?.image = UIImage(named: places[indexPath.row].image)
        
        //круглые фотки
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.height / 2  
        cell.imageOfPlace?.clipsToBounds = true
        
        return cell
    }
    
    // MARK: TableView Delegate
    
   

     /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {
        
    }
    
}
