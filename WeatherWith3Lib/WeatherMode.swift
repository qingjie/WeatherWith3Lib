//
//  WeatherMode.swift
//  Weather
//
//  Created by qingjiezhao on 6/10/15.
//  Copyright (c) 2015 qingjiezhao. All rights reserved.
//

import Foundation

class WeatherMode: NSObject {
    var id : Int
    var name : String
    var temp : Double
    
    init(id : Int, name : String, temp : Double){
        
        self.id = id
        self.name = name
        self.temp = temp
        
        super.init()
    }
}