//
//  MixpanelEvent.swift
//  MixpanelCollector
//
//  Created by Alexander Zaytsev on 7/2/20.
//  Copyright © 2020 zaitsman. All rights reserved.
//

import Foundation

/**
 https://developer.mixpanel.com/reference/events#track-event
 */
public struct MixpanelEvent {
    /**
     A name for the event. For example, "Signed up", or "Uploaded Photo".
     */
    public var event: String
    
    public var properties: [String: Encodable]
    
    /**
     The time an event occurred. If present, the value should be a unix timestamp (seconds since midnight, January 1st, 1970 - UTC). If this property is not included in your request, Mixpanel will use the time the event arrives at the server.
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
