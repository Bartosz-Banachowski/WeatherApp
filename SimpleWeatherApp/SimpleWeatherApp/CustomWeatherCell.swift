//
//  CustomWeatherCellTableViewCell.swift
//  SimpleWeatherApp
//
//  Created by Bartosz Banachowski on 04/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import UIKit

class CustomWeatherCell: UITableViewCell {

    @IBOutlet weak var futureWeatherDate: UILabel!
    @IBOutlet weak var futureWeatherImage: UIImageView!
    @IBOutlet weak var futureTemp: UILabel!
    
    func setFutureWeather(weather: WeatherItem) {
        futureWeatherDate.text = getDayOfWeek(from: weather.date)
        futureTemp.text = weather.temp_C
        futureWeatherImage.loadFromURL(url: weather.imageURL)
    }
    
    private func getDayOfWeek(from date: String) -> String {
        let formatter  = DateFormatter()
        let myCalendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let todayDate = formatter.date(from: date) else {
            return date
        }
        
        let currentDay = myCalendar.component(.weekday, from: todayDate)
        
        switch currentDay {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thurdsay"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return date
        }
    }
}
