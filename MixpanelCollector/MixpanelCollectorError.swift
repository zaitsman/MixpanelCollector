//
//  MixpanelCollectorError.swift
//  MixpanelCollector
//
//  Created by Alexander Zaytsev on 7/2/20.
//  Copyright © 2020 zaitsman. All rights reserved.
//

import Foundation

public enum MixpanelCollectorError:  Error {
    case notInitializedWithToken
    case invalidEventModel(message: String)
    case failedToProduceJsonFromModel
    case failedToResolveUrl
    case other
}
