//
//  Networking.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import Foundation

protocol NetworkingDelegate {
    func didGetResule(data: Data) -> Void
}
    
    
class Networking: NSObject {
    
    var data: Data?
    

    func makeAPIRequest(apiString: String, completion: @escaping (Data) -> Void) -> Void {
        guard let url: URL = URL(string: apiString) else{
            print("ERROR no URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataSession = URLSession.shared
        let dataTask = dataSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard error == nil else{
                print("ERROR found in networking call")
                print(error!)
                return
            }
            
            if data != nil{
                
            
                dataObject = data!
                let theString:NSString = NSString(data: data!, encoding: String.Encoding.ascii.rawValue)!
                print(theString)
                DispatchQueue.main.async {
                    completion(data!)
                }
                
                
                
                
            }else{
                print("ERROR: did not receive data")
            }
        }
        
        dataTask.resume()
    }
    
    
}

