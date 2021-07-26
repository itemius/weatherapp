//
//  Weather.swift
//  weatherapp
//
//  Created by itemius on 17.07.2021.
//

import Foundation

struct Weather {
    let icon: String
    let main: String
    let temperature: Double
    let description: String
}

struct WeatherBase: Decodable {
    let icon: String
    let main: String
    let description: String
}

extension Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case weather
        case main
                
        enum MainKeys: String, CodingKey {
            case temperature = "temp"
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let weatherArray = try container.decode([WeatherBase].self, forKey: .weather)
        
        main = weatherArray.first!.main
        icon = weatherArray.first!.icon
        description = weatherArray.first!.description

        let mainContainer = try container.nestedContainer(keyedBy: CodingKeys.MainKeys.self, forKey: .main)
        temperature = try mainContainer.decode(Double.self, forKey: .temperature)
    }
}
