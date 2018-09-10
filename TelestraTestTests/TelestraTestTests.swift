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
    
    var vc:ViewController!
    
    //Test to find whether controller has a table view
    func testControllerHasTableView() {
         let controller = ViewController()
        controller.loadViewIfNeeded()
        
        XCTAssertNotNil(controller.imageTableView, "Controller should have a tableview")
    }
    
}
