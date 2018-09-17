//
//  TelestraTests.swift
//  TelestraTest
//
//  Created by Adarsh Shrivastava on 17/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import XCTest
@testable import TelestraTest
class TelestraTests: XCTestCase{
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    var vc = ViewController()
    
    //Test to find whether controller has a table view
    func testControllerHasTableView() {
        vc.loadViewIfNeeded()
        
        XCTAssertNotNil(vc.imageTableView, "Controller should have a tableview")
    }
    
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(vc.conforms(to: UITableViewDelegate.self))
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
