//
//  DetailsViewController.swift
//  Proyecto
//
//  Created by Camila Laura Lopez on 19/12/22.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var heroeDescriptionLabel: UILabel!

    @IBOutlet weak var heroeNameLabel: UILabel!
    @IBOutlet weak var heroeImageView: UIImageView!
    
 
    var heroe: Heroe!
    var transformation: [Transformation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.transformationsButton.alpha = 0
        title = heroe.name
        
        heroeImageView.setImage(url: heroe.photo)
        heroeNameLabel.text = heroe.name
        heroeDescriptionLabel.text = heroe.description
        
        
        let token = LocalDataLayer.shared.getToken()
        
        NetworkLayer.shared.fetchTransformations(token: token, heoreID: heroe.id) { [weak self] allTrans, error in
            
            guard let self = self else {return}
            
            if let allTrans = allTrans {
                self.transformation = allTrans
                
                if !self.transformation.isEmpty{
                    DispatchQueue.main.async {
                        self.transformationsButton.alpha = 1
                    }
                }
            }else{
                print("No hay transformaciones, fue un error ", error?.localizedDescription ?? "")
            }
        }
    }
    
    
    @IBAction func trasnformationButton(_ sender: UIButton) {
         
        let transView = TransformationViewController()
        transView.transformation = self.transformation
        
        navigationController?.pushViewController(transView, animated: true)
    
        
    }


}
