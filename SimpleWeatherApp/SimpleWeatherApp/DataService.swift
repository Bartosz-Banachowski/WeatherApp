//
//  DataService.swift
//  SimpleWeatherApp
//
//  Created by Bartosz Banachowski on 04/05/2020.
//  Copyright © 2020 Bartosz Banachowski. All rights reserved.
//

import Foundation
import Alamofire

struct DataService {
    private let APIKey = "key=531364df7b3e49e28c943544202904"
    private let baseURL = "https://api.worldweatheronline.com/premium/v1/weather.ashx?"
    private let mca = "&mca=no"
    private let num_of_days = "&num_of_days=6"
    private let format = "&format=json"
    
    func requestWeatherData(forCity city: String, completion: @escaping (Response?, Error?) -> ()) {
        let URL = "\(baseURL)\(APIKey)\(mca)\(num_of_days)\(format)&q=\(city)"
        print(URL)
        AF.request(URL).responseJSON { (response) in
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let jsonData = response.data {
                do {
                    let weather = try JSONDecoder().decode(Response.self, from: jsonData)
                    completion(weather, nil)
                } catch {
                    print("Unexpected problems during fetching weather data: \(error)")
                }
            }
        }
    }
}
