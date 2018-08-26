//
//  NetworkingFacade.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import Foundation

class NetworkingFacade: NSObject, NetworkingDelegate {
    
    //this class should consist of a Networking Class and a JSONParser Class
    let networking: Networking
    let jsonParser: JSONParser
    var dataObject: Data?
    
    override init() {
        networking = Networking()
        jsonParser = JSONParser()
        
        networking.delegate = self
    }
    func grabDataWithString(string: String) -> Void{
        
        //will call makeAPIRequest method
        print(string)
        networking.makeAPIRequest(apiString: string) { (data) in
            
            DispatchQueue.main.async() {//rework to take out callbackswif
                
                self.dataObject = data
                
                let theString:NSString = NSString(data: self.dataObject!, encoding: String.Encoding.ascii.rawValue)!
                print(theString)
            }
            let theString:NSString = NSString(data: self.dataObject!, encoding: String.Encoding.ascii.rawValue)!
            
            print(theString)
            
        }
        
        
        
    }
    
    func didGetResule(data: Data) -> Void{}
}


