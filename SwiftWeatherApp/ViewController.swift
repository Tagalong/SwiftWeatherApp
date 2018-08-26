//
//  ViewController.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let apiKey: String = "2fb4add23bc2288f44ca26618eae7061"
        let lat: String = "34.088051"
        let long: String = "-118.296512"
        let apiString: String = "https://api.darksky.net/forecast/\(apiKey)/\(lat),\(long)?exclude=currently,minutely,hourly"
        
        let facade = NetworkingFacade()
        facade.grabDataWithString(string: apiString)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

