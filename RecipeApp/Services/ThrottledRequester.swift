//
//  ThrottledRequester.swift
//  RecipeApp
//
//  Created by Yogesh on 1/21/25.
//

import Foundation

class ThrottledRequester {
    private var lastRequestTime: Date?
    private let interval: TimeInterval
    
    init(interval: TimeInterval = 0.5) {
        self.interval = interval
    }
    
    func request(action: @escaping () async -> Void) {
        Task {
            if let lastRequestTime = lastRequestTime {
                let timeSinceLastRequest = -lastRequestTime.timeIntervalSinceNow
                if timeSinceLastRequest < interval {
                    let delay = UInt64((interval - timeSinceLastRequest) * 1_000_000_000)
                    await Task.sleep(delay)
                }
            }
            lastRequestTime = Date()
            await action()
        }
    }
}
