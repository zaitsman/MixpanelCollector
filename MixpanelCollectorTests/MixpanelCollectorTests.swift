//
//  MixpanelCollectorTests.swift
//  MixpanelCollectorTests
//
//  Created by Alexander Zaytsev on 7/2/20.
//  Copyright © 2020 zaitsman. All rights reserved.
//

import XCTest
@testable import MixpanelCollector

class MixpanelCollectorTests: XCTestCase {
    
    override func setUp() {
        MixpanelCollector.shared.setToken("") // set the token here.
    }
    
    override func tearDown() {
        MixpanelCollector.shared.setToken("")
    }
    
    func testEventSubmission() {
        _ = expectation(description: "wait for request")
        try! MixpanelCollector.shared.postEvent(MixpanelEvent("test",
                                                              properties: ["distinct_id": "banana",
                                                                                          "name": "cake"]))
        
        waitForExpectations(timeout: TimeInterval(60), handler: nil)
    }
}
