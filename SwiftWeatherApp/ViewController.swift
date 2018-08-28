//
//  ViewController.swift
//  SwiftWeatherApp
//
//  Created by Mac on 8/25/18.
//  Copyright © 2018 Nice Fun Apps. All rights reserved.
//

import UIKit






class ViewController: UIViewController, NetworkingDelegate {

    var slidesArray: [Slide] = []
    var modelArray: [DayWeather] = []
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollview: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        enum Weather : String {
            case  clear_day, clear_night, rain, snow, sleet, wind, fog, partly_cloudy_day, partly_cloudy_night, cloudy
            
        }
        
        let apiKey: String = "2fb4add23bc2288f44ca26618eae7061"
        let lat: String = "34.088051"
        let long: String = "-118.296512"
        let apiString: String = "https://api.darksky.net/forecast/\(apiKey)/\(lat),\(long)?exclude=currently,minutely,hourly"
        
        let networking = Networking()
        networking.delegate = self
        networking.makeAPIRequest(apiString: apiString)
        
        
        
    }
    
    func didGetResult(data: Data?) {
        
    
            
            do {
                
                let newJSONDecoder = JSONDecoder()
                let weatherObject = try newJSONDecoder.decode(WeatherObj.self, from:data!)
                print(weatherObject)
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
        }
        }
    
    func buildSlides(slidesArray: [DayWeather]) -> Void{
        
        //call setupSlideScrollView pass in DayWeather array
        
        for modelObject in slidesArray{
            
            print(modelObject)
            
            let slide: Slide = Slide()
            print(slide)
            self.slidesArray.append(slide)
            
            //crash is occurring because views have not been added as subviews
            let hiLabelText: String = String(format:"%f", modelObject.temperatureHigh)
            slide.hiLabel.text = hiLabelText
            
            let loLabelText: String = String(format: "%f", modelObject.temperatureLow)
            slide.loLabel.text = loLabelText
            
            let humidityText: String = String(format: "%f%", modelObject.humidity * 100)
            slide.humidityLabel.text = humidityText
            
            let imageName = self.displayImage(name: modelObject.icon)
            slide.descriptionImage.image = UIImage(named: imageName)
            
            slide.descriptionLabel.text = modelObject.summary
            
        }
        self.setupSlideScrollView(slides: self.slidesArray)
    }
        
    func displayImage(name: String)->String {
        switch name {
        case "clear_day":
            return "sunny.png"
        case "clear_night":
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
        case "partly_cloudy_day":
            return "partiallycloudy.png"
        case "partly_cloudy_night":
            return "cloudynight.png"
        case "cloudy":
            return "overcast.png"
        default: return "sunny.png"
        }
    }
    
    func setupSlideScrollView(slideData : [Slide]) {
        scrollview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollview.contentSize = CGSize(width: view.frame.width * CGFloat(slideData.count), height: view.frame.height)
        scrollview.isPagingEnabled = true
        
        for i in 0 ..< slideData.count {
            slideData[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollview.addSubview(slideData[i])
            
            let slideData[i] as? 
            
            slideData[i].hiLabel.text = String(format:"%f", slideData[i].temperatureHigh)
            
            let hiLabelText: String =
            slide.hiLabel.text = hiLabelText
            
            let loLabelText: String = String(format: "%f", modelObject.temperatureLow)
            slide.loLabel.text = loLabelText
            
            let humidityText: String = String(format: "%f%", modelObject.humidity * 100)
            slide.humidityLabel.text = humidityText
            
            let imageName = self.displayImage(name: modelObject.icon)
            slide.descriptionImage.image = UIImage(named: imageName)
            
            slide.descriptionLabel.text = modelObject.summary
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

