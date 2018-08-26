//
//  WeatherObjects.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import Foundation


func myMethod(success:([String])->Void){
    ref?.observeEventType(.Value, withBlock: { snapshot in
        var newNames: [String] = []
        for item in snapshot.children {
            if let item = item as? FIRDataSnapshot {
                let postDict = item.value as! [String: String]
                newNames.append(postDict["name"]!)
            }
        }
        self.didFetchData(newNames)
    })
}

func didFetchData(data:[String]){
    //Do what you want
}
