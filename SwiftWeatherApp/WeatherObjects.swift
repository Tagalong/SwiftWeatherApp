//
//  WeatherObjects.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import Foundation



struct WeatherObj: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let daily: Daily
    
}

struct Daily: Codable{
    let summary: String
    let icon: String
    let data: [DayWeather]
}

struct DayWeather: Codable{
    
    let summary: String
    let icon: String
    let temperatureHigh: Double
    let temperatureLow: Double
    let humidity: Double
    let time: Int
    
}

