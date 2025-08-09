import Foundation

struct CurrentWeatherResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
    let dt: TimeInterval
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double?
    let temp_max: Double?
    let humidity: Int
}

/// 5 days
struct ForecastResponse: Codable {
    let list: [ForecastEntry]
    let city: City
}

struct ForecastEntry: Codable {
    let dt: TimeInterval
    let main: ForecastMain
    let weather: [Weather]
    let dt_txt: String
    
    var date: Date {
        Date(timeIntervalSince1970: dt)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "E, d MMM"
        return formatter.string(from: date)
    }
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct ForecastMain: Codable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}

struct City: Codable {
    let name: String
    let country: String
}
