//
//  PokedexDetailsVC.swift
//  Pokedex
//
//  Created by Asaf Marciano on 24/02/2017.
//  Copyright © 2017 Marciano. All rights reserved.
//

import UIKit

class PokedexDetailsVC: UIViewController {
    
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeSegment: UISegmentedControl!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeDescription: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var evoFirstImage: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var evoNextImage: UIImageView!
    @IBOutlet weak var attackLabel: UILabel!
    var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pokedexLabel.text = pokemon.name
    }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
