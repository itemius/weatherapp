//
//  WeatherAPIClient.swift
//  weatherapp
//
//  Created by itemius on 17.07.2021.
//

import Foundation

class WeatherAPICLient {
    
    static func getWeather(lat: String, lon: String, completion: @escaping (Weather) -> Void) {
        if let url = URL(string: Constants.API.openweathermapURL +
                            "weather?lat=" + lat +
                            "&lon=" + lon +
                            "&appid=" + Constants.API.openweathermapAPIkey +
                            "&units=metric") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                guard let weather = try? decoder.decode(Weather.self, from: data) else {
                    print("parsing error")
                    return
                }
                completion(weather)
              }
           }.resume()
        }
    }
    
    static func downloadWeatherIcon(icon: String, completion: @escaping (Data) -> Void) {
        downloadImage(from: URL(string: Constants.API.openweathermapIconURL + icon + "@2x.png")!, completion: {
            data in
            completion(data)
        })
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    static func downloadImage(from url: URL, completion: @escaping (Data) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data)
        }
    }
}
