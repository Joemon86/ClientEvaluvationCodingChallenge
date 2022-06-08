//
//  ViewControllTest.swift
//  MeaningsTests
//
//  Created by 1964058 on 07/06/22.
//

import XCTest
@testable import Meanings

class ViewControllTest: XCTestCase {

    var systemUnderTest: ViewController!
    
    override func setUpWithError() throws {
        super.setUp()
                
                //get the storyboard the ViewController under test is inside
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                //get the ViewController we want to test from the storyboard (note the identifier is the id explicitly set in the identity inspector)
                systemUnderTest = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
                
                //load view hierarchy
                _ = systemUnderTest.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        systemUnderTest = nil
    }
    
   func testSearchBarTextMinAndMaxLength() {
       systemUnderTest.searchBar.text = "Hmmy"
       if systemUnderTest.checkSearchTextLength(searchText: systemUnderTest.searchBar.text!) {
           XCTAssert(true)
       } else {
           XCTAssert(false)
       }
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
