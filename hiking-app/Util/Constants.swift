import Foundation

enum Constants {
    
    enum WeatherApi {
        static let weatherAPIKey = EnvParser.shared.value(fileName: "keys.env", value: "OPEN_WEATHER_FORECAST_API_KEY") ?? ""
        static let fiveDaysForecastAPIQuery = EnvParser.shared.value(fileName: "keys.env", value: "API_QUERY_5DAYS_FORECAST") ?? ""
        static let currentWeatherAPIQuery = EnvParser.shared.value(fileName: "keys.env", value: "API_QUERY_CURRENT_DAY_FORECAST") ?? ""
        
        static let fiveDaysForecastEndPoint = "forecast"
        static let currentDayForecastEndPoint = "weather"
    }
    
    
}
