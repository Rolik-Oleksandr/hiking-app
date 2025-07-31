import Foundation

enum Constants {
    static let weatherAPIKey = EnvParser.shared.value(fileName: "keys.env", value: "OPEN_WEATHER_FORECAST_API_KEY") ?? ""
}
