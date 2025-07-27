import Foundation

struct WeatherForecastModel: Codable, Identifiable {
    let id = UUID()
    let date: String
    let highTemp: Double
    let lowTemp: Double
    let windSpeed: Double
    let rh: Int
    let pop: Double
    let weather: WeatherForecastDescription
    let temp: Double?
    
    enum CodingKeys: String, CodingKey {
        case date = "valid_date"
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case windSpeed = "wind_spd"
        case rh, pop
        case weather
        case temp
    }
}

struct WeatherForecastDescription: Codable {
    let description: String
    let icon: String
}
