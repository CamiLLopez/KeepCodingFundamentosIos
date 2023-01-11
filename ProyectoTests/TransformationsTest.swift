//
//  TransformationsTest.swift
//  ProyectoTests
//
//  Created by Camila Laura Lopez on 21/12/22.
//

import XCTest

final class TransformationsTest: XCTestCase {
    
    
    var transformation: Transformation!
    
    
        override func setUp()  {
            super.setUp()
            
            
            transformation = Transformation(id: "89",
                          name: "Goku",
                          description: "Goku lalalalala",
                          photo: "https://www.keepcoding.io"
                          )
        }
        
        override func tearDown()  {
            transformation = nil
            super.tearDown()
        }
        
        
        func testTransformationId(){
            XCTAssertNotNil(transformation.id)
            XCTAssertEqual(transformation.id, "89")
            XCTAssertNotEqual(transformation.id, "7")
        }
        
        
        func testTransformationPhoto(){
            
            let url = URL(string: transformation.photo)
            XCTAssertNotNil(url?.absoluteURL)
            XCTAssertNotNil(transformation.photo)
            XCTAssertEqual(transformation.photo, "https://www.keepcoding.io")
            XCTAssertNotEqual(transformation.id, "https://www.keepcoding.com")
        }
        func testTransformationName(){
            XCTAssertNotNil(transformation.name)
            XCTAssertEqual(transformation.name, "Goku")
            XCTAssertNotEqual(transformation.name, "Vegeta")
        }
        
        func testTransformationDescription(){
            XCTAssertNotNil(transformation.description)
            XCTAssertEqual(transformation.description, "Goku lalalalala")
            XCTAssertNotEqual(transformation.description, "Lolololo")
        }

}
