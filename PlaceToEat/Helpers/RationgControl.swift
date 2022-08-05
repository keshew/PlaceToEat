//
//  RationgControl.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 01.08.2022.
//

import UIKit

@IBDesignable class RationgControl: UIStackView {

    //MARK: - properties
    
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    
    //MARK: - initialization
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: -  buttons action
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        //Calculate the rating of selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
    
    
    
    //MARK: - setup buttons
    
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Load button image
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        
        let highliatedStar = UIImage(named: "highliatedStar",
                                     in: bundle,
                                     compatibleWith: self.traitCollection)
        
        
        
        for _ in 1...starCount {
        let button = UIButton()
        
        // set image
        button.setImage(emptyStar, for: .normal)
        button.setImage(filledStar, for: .selected)
        button.setImage(highliatedStar, for: .highlighted)
        button.setImage(highliatedStar, for: [.highlighted, .selected])
        
        //constr
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.width).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.height).isActive = true
        
        //setup the button action
        button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
        //add button to the stack
        addArrangedSubview(button)
            
        //add the new button on the rating button array
        ratingButtons.append(button)
        }
        
        updateButtonSelectionState()
    }

    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
        
    }
    
    
    
}
