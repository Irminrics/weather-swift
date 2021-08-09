//
//  Date.swift
//  WeatherApp
//
//  Created by Jun Kang on 6/8/21.
//

import Foundation

extension Date {

    // Convert local time to GMT
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }

    // Convert GMT to specfic timezone time
    func toLocalTime(secondsFromGMT: Int) -> Date {
        let seconds = TimeInterval(secondsFromGMT)
        return Date(timeInterval: seconds, since: self)
    }
    
    func toTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return(dateFormatter.string(from: self))
    }

}
