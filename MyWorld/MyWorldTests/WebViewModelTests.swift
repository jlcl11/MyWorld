//
//  WebViewModelTests.swift
//  MyWorldTests
//
//  Created by José Luis Corral López on 16/8/24.
//

import XCTest
@testable import MyWorld

class WebViewModelTests: XCTestCase {
    
    var viewModel: WebViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = WebViewModel(url: "https://initial.url")
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertEqual(viewModel.url, "https://initial.url")
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertFalse(viewModel.isContentEmpty)
    }
    
    func testChangeURL() {
        viewModel.changeURL(to: "https://new.url")
        
        XCTAssertEqual(viewModel.url, "https://new.url")
        XCTAssertTrue(viewModel.isLoading)
        XCTAssertFalse(viewModel.isContentEmpty)
    }
}
