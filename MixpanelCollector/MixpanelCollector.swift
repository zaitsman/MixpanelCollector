//
//  MixpanelCollector.swift
//  MixpanelCollector
//
//  Created by Alexander Zaytsev on 7/2/20.
//  Copyright © 2020 zaitsman. All rights reserved.
//

import Foundation

public class MixpanelCollector {
    public static let shared = MixpanelCollector()
    
    fileprivate var token: String?
    
    fileprivate var distinct_Id: String?
    
    fileprivate init() {
        
    }
    
    @discardableResult
    public func setToken(_ token: String) -> MixpanelCollector {
        self.token = token
        return self
    }
    
    /**
     Set the distinct_id that will be used to group events together in Mixpanel a-la user profile.
     
     - parameters:
        - distinct_Id: The distinct id.
     */
    @discardableResult
    public func setDistinctId(_ distinct_Id: String) -> MixpanelCollector {
        self.distinct_Id = distinct_Id
        return self
    }
    
    public func postEvent(_ event: MixpanelEvent) throws {
        guard let tok = self.token else {
            throw MixpanelCollectorError.notInitializedWithToken
        }
        
        var props: [String: Any] = event.properties
        props["token"] = tok
        
        if let distinct = self.distinct_Id {
            props["distinct_id"] = distinct
        }
        
        if let eventTime = event.time {
            props["time"] = eventTime
        }
        
        let dict: [String: Any] = ["event": event.event, "properties" : props]
        
        if !JSONSerialization.isValidJSONObject(dict) {
            throw MixpanelCollectorError.invalidEventModel(message: "Invalid event")
        }
        
        if let json = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed) {
            let b64 = json.base64EncodedString()
            
            if let urlComponents = URLComponents(string: "https://api.mixpanel.com/track/") {
                var url = urlComponents
                url.queryItems = [
                    URLQueryItem(name: "data", value: b64)
                ]
                
                if let requestUrl = url.url {
                    var request = URLRequest(url: requestUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: TimeInterval(30))
                    request.httpMethod = "GET"
                    
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data else { return }
                        print(String(data: data, encoding: .utf8)!)
                    }
                    
                    task.resume()
                } else {
                    throw MixpanelCollectorError.failedToResolveUrl
                }
            } else {
                throw MixpanelCollectorError.failedToResolveUrl
            }
        }
    }
}
