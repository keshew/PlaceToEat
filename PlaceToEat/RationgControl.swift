//
//  RationgControl.swift
//  PlaceToEat
//
//  Created by Артём Коротков on 01.08.2022.
//

import UIKit

@IBDesignable class RationgControl: UIStackView {

    //MARK: - properties
    
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
    
    var rating = 0
    
    
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
        print("yo")
    }
    
    
    
    //MARK: - setup buttons
    
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 1...starCount {
        let button = UIButton()
        button.backgroundColor = .red
        
        //constr
        button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        //setup the button action
        button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
        //add button to the stack
        addArrangedSubview(button)
            
        //add the new button on the rating button array
        ratingButtons.append(button)
        }
}

}
