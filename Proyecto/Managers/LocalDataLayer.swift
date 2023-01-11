//
//  File.swift
//  Proyecto
//
//  Created by Camila Laura Lopez on 15/12/22.
//

import Foundation

final class LocalDataLayer {
    
    static let shared = LocalDataLayer()
    private static let token = "token"
    private static let heores = "heores"
    
    func save(token: String){
        UserDefaults.standard.set(token, forKey: Self.token)
    }
    
    func getToken()-> String{
        UserDefaults.standard.string(forKey: Self.token) ?? ""
    }
    func isUserLogged()-> Bool{
        !getToken().isEmpty
    }
    
    func save(heroes: [Heroe]){
        if let endodedHeroes = try? JSONEncoder().encode(Self.heores){
            UserDefaults.standard.set(endodedHeroes, forKey: Self.heores)
        }
    }
    func getHeroes()-> [Heroe]{
        if let savedHeroesData = UserDefaults.standard.object(forKey: Self.heores) as? Data{
            do{
                let savedHeores = try JSONDecoder().decode([Heroe].self, from: savedHeroesData)
                return savedHeores
            }catch{
                print("Somethin went wrong!!")
                return []
            }
            
            
        }else{
            return []
        }
    }
    
}
