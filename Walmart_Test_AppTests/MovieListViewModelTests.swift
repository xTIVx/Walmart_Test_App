//
//  MovieListViewModelTests.swift
//  Walmart_Test_AppTests
//
//  Created by Igor Chernobai on 7/16/21.
//

import XCTest

@testable import Walmart_Test_App


class MovieListViewModelTests: XCTestCase {

    var sut: MovieListViewModel?
    

    override func setUpWithError() throws {

        sut = MovieListViewModel()
    }

    override func tearDownWithError() throws {

        sut = nil
    }


    func testFetchMovieData() {
        guard let sut = sut else {return}
        let expectation = expectation(description: "DataRecieved")

        sut.fetchMovieData(completion: {
            XCTAssertNotNil(sut.getMovieForCell(at:0), "Data was not recieved")
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 5)
    }


}
