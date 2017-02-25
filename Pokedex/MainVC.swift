//
//  ViewController.swift
//  Pokedex
//
//  Created by Asaf Marciano on 21/02/2017.
//  Copyright © 2017 Marciano. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var player : AVAudioPlayer!
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var searchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        
        parseCSVfile()
        playSong()
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func parseCSVfile(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows{
                let name = row["identifier"]!
                let id = Int(row["id"]!)!
                let poke = Pokemon(name: name, pokedexId: id)
                pokemons.append(poke)
            }
            
        } catch{
            print("error")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell {
            
            let pokemon: Pokemon!
            if searchMode{
                pokemon = filteredPokemons[indexPath.row]
            } else{
                pokemon = pokemons[indexPath.row]
            }
            
            cell.configueCell(pokemon: pokemon)
            return cell
        } else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon: Pokemon!
        if searchMode{
            pokemon = filteredPokemons[indexPath.row]
        } else{
            pokemon = pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokedexDetailsVC", sender: pokemon)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokedexDetailsVC"{
            if let destinstion = segue.destination as? PokedexDetailsVC{
                if let poke = sender as? Pokemon{
                    destinstion.pokemon = poke
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchMode{
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func playSong(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do{
            player = try AVAudioPlayer(contentsOf: URL(string: path)!)
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
        }catch{
            print("error")
        }
    }

    
    @IBAction func musicPressed(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            sender.alpha = 0.2
        } else{
            player.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text==nil) || (searchBar.text==""){
            searchMode = false
            collection.reloadData()
            view.endEditing(true)
        } else {
            searchMode = true
            let word = searchBar.text?.lowercased()
            filteredPokemons = pokemons.filter({($0.name.range(of: word!) != nil)})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }


}

