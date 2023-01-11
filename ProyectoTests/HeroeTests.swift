//
//  HeroeTests.swift
//  ProyectoTests
//
//  Created by Camila Laura Lopez on 21/12/22.
//

import XCTest


final class HeroeTests: XCTestCase {
    
    var heroe: Heroe!
    
    
    
    
    
    override func setUp()  {
        super.setUp()
        
        
        heroe = Heroe(id: "4",
                      name: "Goku",
                      description: "Goku lalalalala",
                      photo: "https://www.keepcoding.io",
                      favorite: false)
    }
    
    override func tearDown()  {
        heroe = nil
        super.tearDown()
    }
    
    
    func testHeroeId(){
        XCTAssertNotNil(heroe.id)
        XCTAssertEqual(heroe.id, "4")
        XCTAssertNotEqual(heroe.id, "7")
    }
    
    
    func testHeroePhoto(){
        
        let url = URL(string: heroe.photo)
        XCTAssertNotNil(url?.absoluteURL)
        XCTAssertNotNil(heroe.photo)
        XCTAssertEqual(heroe.photo, "https://www.keepcoding.io")
        XCTAssertNotEqual(heroe.id, "https://www.keepcoding.com")
    }
    func testHeroeName(){
        XCTAssertNotNil(heroe.name)
        XCTAssertEqual(heroe.name, "Goku")
        XCTAssertNotEqual(heroe.name, "Vegeta")
    }
    
    func testHeroeDescription(){
        XCTAssertNotNil(heroe.description)
        XCTAssertEqual(heroe.description, "Goku lalalalala")
        XCTAssertNotEqual(heroe.description, "Lolololo")
    }
    func testHeroeFavourite(){
        XCTAssertNotNil(heroe.favorite)
        XCTAssertEqual(heroe.favorite, false)
      
      
    }
    
}
