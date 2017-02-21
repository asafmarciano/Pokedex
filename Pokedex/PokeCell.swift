//
//  PokeCell.swift
//  Pokedex
//
//  Created by Asaf Marciano on 21/02/2017.
//  Copyright © 2017 Marciano. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeLabel: UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder: NSCoder){
      super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configueCell(pokemon: Pokemon){
        self.pokemon = pokemon;
        pokeLabel.text = pokemon.name.capitalized
        pokeImg.image = UIImage(named: "\(pokemon.pokedexId)")
    }
    
}
