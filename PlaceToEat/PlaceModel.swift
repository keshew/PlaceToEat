//
//  PlaceModel.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 27.07.2022.
//

import Foundation

struct Place {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    
    
  static  var cafeTest = ["TramCafe","yChurki"]
    
  static  func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in cafeTest {
            places.append(Place(name: place, location: "Perm", type: "Cafe", image: place))
        }
        
        return places
        
    }
    
    
}
