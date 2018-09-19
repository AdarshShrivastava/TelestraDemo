//
//  TelestraTests.swift
//  TelestraTest
//
//  Created by Adarsh Shrivastava on 17/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import XCTest
//import TelestraViewModel

@testable import TelestraTest
class TelestraTests: XCTestCase{
    var sessionUnderTest:URLSession!
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        sessionUnderTest = nil
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
    
    //Test to verify URL
    func testValidCallToGetStatusCode200(){
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        let promise = expectation(description: "status code: 200")
        let dataTask =  sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            if let error = error{
                XCTFail("error:\(error.localizedDescription)")
            }else if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 200{
                    promise.fulfill()
                }else{
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
