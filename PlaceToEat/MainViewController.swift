//
//  MainViewController.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 27.07.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet var reversedSotrButton: UIBarButtonItem!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    private var searhcController = UISearchController(searchResultsController: nil)
    private var places: Results<Place>!
    private var ascendingSotring = true
    private var filtredPlaces: Results<Place>!
    private var searchBarIsEmpty: Bool {
        guard let text = searhcController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searhcController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = realm.objects(Place.self)
        
        searhcController.searchResultsUpdater = self
        searhcController.obscuresBackgroundDuringPresentation = false
        searhcController.searchBar.placeholder = "Search"
        navigationItem.searchController = searhcController
        definesPresentationContext = true
    }

    // MARK: - Table view data source
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         if isFiltering {
             return filtredPlaces.count
         }
        return places.isEmpty ? 0 : places.count
    }


     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

         var place = Place()
         
         if isFiltering == true {
             place = filtredPlaces[indexPath.row]
         } else {
             place = places[indexPath.row]
         }
         
        
        cell.nameLabel?.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)

        //круглые фотки
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.height / 2
        cell.imageOfPlace?.clipsToBounds = true

        return cell
    }

    // MARK: TableView Delegate
    
    //new method to delete objc
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let place = places[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _)  in
            
            storageManager.deleteObject(place)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
        }
        return deleteAction
    }
    
     func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
        
    }

     
     //MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let place: Place
            if isFiltering {
                place = filtredPlaces[indexPath.row]
            } else {
                place = places[indexPath.row]
            }
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = place
            
        }
    }
    

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVc = segue.source as? NewPlaceViewController else { return }

        newPlaceVc.savePlace()
        tableView.reloadData()
        
    }
    
    
    @IBAction func sotrSelection(_ sender: UISegmentedControl) {
        
        sorting()
    }
    
    @IBAction func reversedSotring(_ sender: Any) {
        
        ascendingSotring.toggle()
        
        if ascendingSotring == true {
            reversedSotrButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reversedSotrButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    
    
    private func sorting() {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSotring)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSotring)
        }
        tableView.reloadData()
    }
}


extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filtredPlaces = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@ OR type CONTAINS[c] %@", searchText, searchText, searchText)
        
        tableView.reloadData()
    }
    
}

