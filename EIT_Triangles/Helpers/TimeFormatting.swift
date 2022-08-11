//
//  TimeFormatting.swift
//  EIT_Triangles
//
//  Created by Danil Peregorodiev on 11.08.2022.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes < 120 {
        return "\(minutes) минут назад"
    } else if minutes >= 120 && hours < 48 {
        return "\(hours) часов назад"
    } else {
        return "\(days) дней назад"
    }
}
