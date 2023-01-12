//
//  CollectionViewController.swift
//  Proyecto
//
//  Created by Oscar Rodriguez Garrucho on 13/12/22.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var logOutButton: UIButton!
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        UIApplication
            .shared
            .connectedScenes
            .compactMap{($0 as? UIWindowScene)?.keyWindow}
            .first?
            .rootViewController = LoginViewController()
    }
    var heroes: [Heroe] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        heroes = LocalDataLayer.shared.getHeroes()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationItem.title = "Heroes Collection"
        
        let xib = UINib(nibName: "CollectionCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "customCollectionCell")
        
        let token = LocalDataLayer.shared.getToken()
        NetworkLayer.shared.fetchHeroes(token: token){ [weak self] allHeroes, error in
            guard let self = self else { return }
            
            if let allHeroes = allHeroes {
                self.heroes = allHeroes
                LocalDataLayer.shared.save(heroes: allHeroes)
                
                // refresh tableView con new data fetched from API
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }else{
                print("Error fetching heroes: ", error?.localizedDescription ?? "")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCollectionCell", for: indexPath) as! CollectionCell
        let heroe = heroes[indexPath.row]
        cell.iconImageView.setImage(url: heroe.photo)
        cell.titleLabel.text = heroe.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = (itemsInRow - 1) * spacing
        let finalWidth = (collectionView.frame.width - totalSpacing) / itemsInRow

        return CGSize(width: finalWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroe = heroes[indexPath.row]
        let detailsView = DetailsViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }

}
