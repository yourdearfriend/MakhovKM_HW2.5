//
//  ResultViewController.swift
//  myquiz
//
//  Created by Konstantin on 01.09.2020.
//  Copyright © 2020 Konstantin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var descriptionAnimalLabel: UILabel!
    @IBOutlet var emojiAnimalLabel: UILabel!
    
    // MARK: - Public Properties
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        emojiAnimalLabel.text = "Вы — \(countAnimals(for: answers).rawValue)"
        descriptionAnimalLabel.text = "\(countAnimals(for: answers).definition)"
    }
}
    // MARK: - Private Methodes
extension ResultViewController {
    private func countAnimals (for animals: [Answer]) -> AnimalType {
        
        var dogs: [AnimalType] = []
        var cats: [AnimalType] = []
        var rabbits: [AnimalType] = []
        var turtles: [AnimalType] = []
        
        for animal in animals {
            switch animal.type {
            case .dog:
                dogs.append(.dog)
            case .cat:
                cats.append(.cat)
            case .rabbit:
                rabbits.append(.rabbit)
            case .turtle:
                turtles.append(.turtle)
            }
        }
        
        if dogs.count >= cats.count,
            dogs.count >= rabbits.count,
            dogs.count >= turtles.count {
            return AnimalType.dog
        } else if cats.count >= dogs.count,
            cats.count >= rabbits.count,
            cats.count >= turtles.count {
            return AnimalType.cat
        } else if rabbits.count >= dogs.count,
            rabbits.count >= cats.count,
            rabbits.count >= turtles.count {
            return AnimalType.rabbit
        } else {
            return AnimalType.turtle
        }
    }
}
