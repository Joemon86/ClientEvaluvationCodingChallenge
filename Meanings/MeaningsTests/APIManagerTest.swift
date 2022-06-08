//
//  APIManagerTest.swift
//  MeaningsTests
//
//  Created by 1964058 on 02/06/22.
//

import XCTest
@testable import Meanings
class APIManagerTest: XCTestCase {
    fileprivate var baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py?sf="
   
    var apiManger:APIManager!
    var mockSession:MockURLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        mockSession = MockURLSession()
        apiManger = APIManager(session: mockSession)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        mockSession = nil
        apiManger = nil
    }
    
    func testApiforCorrectUrl() {
       
        if let url = URL(string: baseURL) {
            apiManger.loadData(from: url ) { result in }
        }
        if let cachedUrl = mockSession.cachedUrl {
            XCTAssertEqual(cachedUrl.host, "www.nactem.ac.uk")
        }
        
    }

}

class MockURLSession: NetworkSession {
    typealias Handler = NetworkSession.Handler
    var data:Data?
    var error:Error?
    var cachedUrl:URL?
    var response:URLResponse?
    func loadData(from url: URL, completion: @escaping Handler) {
        self.cachedUrl = url
        completion(data,response, error)
    }
}
