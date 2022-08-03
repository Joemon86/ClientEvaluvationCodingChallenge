////
////  ViewControllTest.swift
////  MeaningsTests
////
////  Created by 1964058 on 07/06/22.
////
//
//import XCTest
//@testable import Meanings
//
//class ViewControllTest: XCTestCase {
//
//    var systemUnderTest: ViewController!
//
//    override func setUpWithError() throws {
//        super.setUp()
//
//                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                systemUnderTest = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//                _ = systemUnderTest.view
//    }
//
//    override func tearDownWithError() throws {
//        super.tearDown()
//        systemUnderTest = nil
//    }
//
//   func testSearchBarTextMinAndMaxLength() {
//       systemUnderTest.searchBar.text = "Hmmy"
//       if systemUnderTest.checkSearchTextLength(searchText: systemUnderTest.searchBar.text!) {
//           XCTAssert(true)
//       } else {
//           XCTAssert(false)
//       }
//    }
//
//}
