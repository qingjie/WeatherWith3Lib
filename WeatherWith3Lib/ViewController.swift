//
//  ViewController.swift
//  WeatherWith3Lib
//
//  Created by qingjiezhao on 6/11/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weatherMode:WeatherMode?
    
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemp: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=Syracuse,NY")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okTapped(sender: AnyObject) {
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=\(txtCity.text)")
    }
    
    func getWeatherData( urlString : String){

        var hud = MBProgressHUD()
        hud.labelText = "Loading"
        hud.dimBackground = true
        self.view.addSubview(hud)
        hud.show(true)
        
        request(.GET, urlString).validate(statusCode: 200..<300).responseJSON { (req,res,json,error) in
            hud.hide(true)
            if error == nil {
                println("Success")
                let weatherJson = JSON(json!)
                
                var id = weatherJson["id"].int
                var cityName = weatherJson["name"].string
                var temprature = weatherJson["main"]["temp"].double
                
                var tempID : Int = id!
                var tempCityName : String = cityName!
                var tempTemprature : Double = temprature!
                
                println(tempID)
                println(tempCityName)
                println(tempTemprature)
                
                self.weatherMode = WeatherMode( id:tempID, name:tempCityName, temp:tempTemprature)
                self.setLabels()
            }else{
                println("Error: \(error)")
            }
        
        }
    }
    
    func setLabels(){
        
        if let name = self.weatherMode?.name{
            self.cityName.text = name
        }
        
        if let temp = self.weatherMode?.temp{
            var temperature = round(((temp - 273.15) * 1.8) + 32)
            self.cityTemp.text = String(format: "%.2f", temperature)
                
        }
    }
}