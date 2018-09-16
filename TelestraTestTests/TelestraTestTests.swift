//
//  TelestraTestTests.swift
//  TelestraTestTests
//
//  Created by Adarsh Shrivastava on 05/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import XCTest

@testable import TelestraTest

class TelestraTestTests: XCTestCase {
    
    var vc = ViewController()
    
    //Test to find whether controller has a table view
    func testControllerHasTableView() {
        vc.loadViewIfNeeded()
        
        XCTAssertNotNil(vc.imageTableView, "Controller should have a tableview")
    }
    
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(vc.conforms(to: UITableViewDelegate.self))
    }
    
    func testToVerifyTheTitleLabel() {
        let expectation = self.expectation(description: "loading")
        
        vc.loadViewIfNeeded()

        vc.viewModelObject.makeTheAPIcall()
        
        XCTAssertNotNil(vc.titleStr, "Title Should not be empty")
        
        expectation.fulfill()
        waitForExpectations(timeout: 20, handler: nil)
        //XCTAssertEqual(self.vc.titleLabel.text, "About Canada")
    }
}


