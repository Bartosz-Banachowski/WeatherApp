//
//  ViewController.swift
//  SimpleWeatherApp
//
//  Created by Bartosz Banachowski on 04/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var currentImgWeather: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var futureWeatherTableView: UITableView!
    private let weatherViewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        futureWeatherTableView.delegate = self
        futureWeatherTableView.dataSource = self
        
        setupWeatherView()
    }

    func setupWeatherView() {
        weatherViewModel.getWeatherData()
        
        weatherViewModel.finishSetupView = {
            self.cityLabel.text = self.weatherViewModel.weather?.city
            self.currentTemp.text = self.weatherViewModel.weather?.temp_C
            self.currentImgWeather.loadFromURL(url: self.weatherViewModel.weather?.imageURL)
            self.futureWeatherTableView.reloadData()
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherViewModel.futureWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherItem", for: indexPath) as! CustomWeatherCell
        let weatherItem = weatherViewModel.futureWeather[indexPath.row]
        cell.setFutureWeather(weather: weatherItem)
        return cell
    }
}

