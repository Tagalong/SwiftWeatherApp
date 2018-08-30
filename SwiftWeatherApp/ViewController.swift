//
//  ViewController.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import UIKit
import CoreLocation



class ViewController: UIViewController, NetworkingDelegate, CLLocationManagerDelegate {
    let locationManager: CLLocationManager = CLLocationManager()
    var slidesArray: [Slide] = []
    var modelArray: [DayWeather] = []
    var lat: String?
    var long: String?
   
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollview: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingLocation()
        
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations{
            print("\(index)\(currentLocation)")
        }
        print("Did Location Delegate get called?")
        let location: CLLocation = locations.first as! CLLocation
        print(location)
        self.lat = String(format: "%f", location.coordinate.latitude)
        self.long = String(format: "%f", location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
        
        self.getWeatherData(latitude: self.lat!, longitude: self.long!)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let alert: UIAlertController = UIAlertController(title: "Error", message: "There was an error getting your location", preferredStyle:UIAlertControllerStyle(rawValue: 1)!)
        
        
        alert.show(self, sender: nil)
    }
    
    

    
    func getWeatherData(latitude: String, longitude: String) -> Void {
        print("Did getWeatherData get called?")
        let apiKey: String = "2fb4add23bc2288f44ca26618eae7061"
        let apiString: String = "https://api.darksky.net/forecast/\(apiKey)/\(latitude),\(longitude)?exclude=currently,minutely,hourly"
        
        let networking = Networking()
        networking.delegate = self
        networking.makeAPIRequest(apiString: apiString)
    }
    
    func didGetResult(data: Data?) {
        
    
            
            do {
                
                let newJSONDecoder = JSONDecoder()
                let weatherObject = try newJSONDecoder.decode(WeatherObj.self, from:data!)
                let dailyObject = weatherObject.daily
                let dataArray = dailyObject.data
            
                for val in dataArray {

                    
                self.modelArray.append(val)
                    
                }
            } catch {
                print("error while parsing:\(error.localizedDescription)")
            }

        DispatchQueue.main.async {
            
            self.buildSlides(slidesArray: self.modelArray)
            self.modelArray = []
            }
        
        }

    
   
        
    func displayImage(name: String)->String {
        switch name {
        case "clear-day":
            return "sunny.png"
        case "clear-night":
            return "clearnight.png"
        case "rain":
            return "rainy.png"
        case "snow":
            return "snowy.png"
        case "sleet":
            return "sleet.png"
        case "wind":
            return "windy.png"
        case "fog":
            return "foggy.png"
        case "partly-cloudy-day":
            return "partiallycloudy.png"
        case "partly-cloudy-night":
            return "cloudynight.png"
        case "cloudy":
            return "overcast.png"
        default: return "sunny.png"
        }
    }
    
    func setupSlideScrollView(slides: [Slide]) {
        
        let viewsToRemove: [UIView] = self.scrollview.subviews
        for views in viewsToRemove {
            views.removeFromSuperview()
        }
        scrollview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollview.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollview.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollview.addSubview(slides[i])
            
        }
    }
    

    
    func buildSlides(slidesArray: [DayWeather]) -> Void{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.numberStyle = .none
        
        for modelObject in slidesArray{
            

            let slide  = Bundle.main.loadNibNamed("Slide", owner: nil, options: nil)![0] as! Slide
           
            let highText = numberFormatter.string(from: modelObject.temperatureHigh as NSNumber) ?? "n/a"
            
           
            slide.hiLabel.text = "High: \(highText)°"
            
            let loLabelText: String = numberFormatter.string(from: modelObject.temperatureLow as NSNumber) ?? "n/a"
            slide.loLabel.text = "Low: \(loLabelText)°"
            
            
            let humidityDegree: Double = modelObject.humidity * 100
            let humidityText: String = numberFormatter.string(from: humidityDegree as NSNumber) ?? "n/a"
            slide.humidityLabel.text = "Humidity: \(humidityText)°"
            
            let imageName = displayImage(name: modelObject.icon)
            slide.descriptionImage.image = UIImage(named: imageName)
            
            slide.descriptionLabel.text = modelObject.summary
            
            let timeDouble: Double = Double(modelObject.time)
            let date = Date(timeIntervalSince1970: timeDouble)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd"
                
            dateFormatter.locale = NSLocale(localeIdentifier: "@en-US") as Locale?
                let localDate = dateFormatter.string(from: date)
            slide.dayLabel.text = localDate
            print("Slide \(slide)")
            self.slidesArray.append(slide)
            
        }
        
        self.setupSlideScrollView(slides: self.slidesArray)
        self.slidesArray = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }


}
