//
//  MeaningsViewModelTest.swift
//  MeaningsTests
//
//  Created by 1964058 on 02/06/22.
//

import XCTest
@testable import Meanings

class MeaningsViewModelTest: XCTestCase {
    
    var viewModel:MeaningsViewModel!
    var meanings:[MeaningCellViewModel]!

    override func setUpWithError() throws {
        super.setUp()
        viewModel = MeaningsViewModel()
        let data = try getData(fromJSON: "Meanings")
       
        let meaning:[Meaning] = try JSONDecoder().decode([Meaning].self, from: data)
        var meanings = [MeaningCellViewModel]()
        if meaning.isEmpty == false {
            var lfs:[lfs] = []
            if let first = meaning.first, let meanings = first.lfs {
                lfs = meanings
            }
            for item in lfs {
                meanings.append(MeaningCellViewModel(meaningText: item.lf))
            }
        }
        self.meanings = meanings
        
    }

    override func tearDownWithError() throws {
        super.tearDown()
        viewModel = nil
        meanings = nil
    }
    
    func testFetchMeaningWithSearchResult() {
        let expectation = self.expectation(description: "fetchmeanings")
        //expectation.isInverted = true
        viewModel.fetchMeaning(with: "Hmm") { status,errorMessage  in
            if status == true {
                expectation.fulfill()
            } else {
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(self.viewModel.maeningCellViewModel?.count, self.meanings.count)
    }

    func testFetchMeaningWithNoResult() {
            let expectation = self.expectation(description: "fetchmeanings")
            viewModel.fetchMeaning(with: "U") { status,errorMessage  in
                if status == true {
                } else {
                    expectation.fulfill()
                }
            }
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertEqual(self.viewModel.maeningCellViewModel?.count, 0)
        }

}

