//
//  DateUtils.swift
//  SwiftUI_Eyepetizer
//
//  Created by heytea on 2025/2/8.
//

import Foundation

struct DateUtils {
    
    static func formatDuration(_ durationInSeconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: TimeInterval(durationInSeconds)) ?? "00:00"
    }
    
    static func formatTimestamp(_ timestamp: TimeInterval, formart: String = "yyyy/MM/dd HH:mm") -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formart
        
        return dateFormatter.string(from: date)
    }
    
}
