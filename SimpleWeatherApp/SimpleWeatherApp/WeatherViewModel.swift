//
//  WeatherViewModel.swift
//  SimpleWeatherApp
//
//  Created by Bartosz Banachowski on 04/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation

class WeatherViewModel: NSObject {
    
    var weather: WeatherItem?
    var futureWeather: [WeatherItem] = []
    private var weatherService = DataService()
    private var data: DataClass? {
        didSet {
            guard self.data != nil else {
                return
            }
            self.setupWeatherItem(with: data!)
            self.fetchFutureWeatherImg(with: data!)
            self.finishSetupView?()
        }
    }
    
    var finishSetupView: (() -> Void)?

    func getWeatherData() {
        weatherService.requestWeatherData(forCity: "Lodz") { (response, error) in
            if let error = error {
                print(error)
                return
            }
            self.data = response?.data
        }
    }
    
    // Get only needed values from the response
    private func setupWeatherItem(with response: DataClass) {
        weather = WeatherItem(city: response.request[0].query,
                              temp_C: response.currentCondition[0].tempC + " °C",
                              date: response.weather[0].date,
                              imageURL: response.currentCondition[0].weatherIconURL[0].value)
        
        //setup future weather for next 6 days
        for item in response.weather {
            futureWeather.append(WeatherItem(city: "",
                                              temp_C: item.avgtempC + " °C",
                                              date: item.date,
                                              imageURL: ""))
        }
        futureWeather.removeFirst()
    }
    
    private func fetchFutureWeatherImg(with response: DataClass) {
        for i in 0..<futureWeather.count {
            futureWeather[i].imageURL = response.weather[i].hourly[0].weatherIconURL[0].value
        }
    }
}
