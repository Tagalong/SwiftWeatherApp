//
//  WeatherDataObject.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/27/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import Foundation

class WeatherDataObject: NSObject{
    
    
    var summary: String
    var icon: String
    var temperatureHigh: Double
    var temperatureLow: Double
    var humidity: Double
    var time: Int
    
    init(summary: String, icon: String, temperatureHigh: Double, temperatureLow: Double, humidity: Double, time: Int) {
        
 
            self.summary = summary
            self.icon = icon
            self.temperatureHigh = temperatureHigh
            self.temperatureLow = temperatureLow
            self.humidity = humidity
            self.time = time
        
        
    }
    
    
    
}
