import Foundation

enum Constants {
    
    enum WeatherApi {
        static let weatherAPIKey = EnvParser.shared.value(fileName: "keys.env", value: "OPEN_WEATHER_FORECAST_API_KEY") ?? ""
        static let forecastAPIQuery = EnvParser.shared.value(fileName: "keys.env", value: "API_QUERY_FORECAST") ?? ""
        
        static let fiveDaysForecastEndPoint = "forecast"
        static let currentDayForecastEndPoint = "weather"
    }
    
    
}
