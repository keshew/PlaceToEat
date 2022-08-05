//
//  CustomTableViewCell.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 27.07.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var imageOfPlace: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var starRatingOnMain: RationgControl! {
        didSet {
            starRatingOnMain.isUserInteractionEnabled = false
        }
    }
    
}
