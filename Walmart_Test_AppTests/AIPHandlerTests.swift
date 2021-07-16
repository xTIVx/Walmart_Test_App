//
//  Walmart_Test_AppTests.swift
//  Walmart_Test_AppTests
//
//  Created by Igor Chernobai on 7/14/21.
//

import XCTest
@testable import Walmart_Test_App

class AIPHandlerTests: XCTestCase {

    let sut: APIHandler = APIHandler.shared


    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testFetchMovieDetails() {
        let expectation = expectation(description: "MovieDetailsRecieved")
        sut.requestData(endPoint: .movieDetails, movieID: 52125) { response in
            XCTAssertNotNil((response as? Movie), "Movie details was not recieved, double check movieID")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

}
