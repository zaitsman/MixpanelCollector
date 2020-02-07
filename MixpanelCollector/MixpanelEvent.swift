//
//  MixpanelEvent.swift
//  MixpanelCollector
//
//  Created by Alexander Zaytsev on 7/2/20.
//  Copyright © 2020 zaitsman. All rights reserved.
//

import Foundation

public struct MixpanelEvent {
    public var event: String
    public var properties: [String: Encodable]
    
    /**
     If this is specified, then the event is seen as have happened at that time.
     */
    public var time: TimeInterval?
    
    public init(_ event: String, properties: [String: Encodable]) {
        self.event = event
        self.properties = properties
        self.time = nil
    }
    
    public init(_ event: String, properties: [String: Encodable], time: TimeInterval) {
        self.event = event
        self.properties = properties
        self.time = time
    }
}
