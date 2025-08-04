import Foundation
import Combine

class WeatherForecastService {
    func fetchCurrentForecast(city: String) -> AnyPublisher<CurrentWeatherResponse, Error> {
        guard let url = urlBuider(endpoint: Constants.WeatherApi.currentDayForecastEndPoint, city: city) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CurrentWeatherResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetch5DaysForecast(city: String) -> AnyPublisher<ForecastResponse, Error> {
        guard let url = urlBuider(endpoint: Constants.WeatherApi.fiveDaysForecastEndPoint, city: city) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: ForecastResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func urlBuider(endpoint: String, city: String) -> URL? {
        var components = URLComponents(string: "\(Constants.WeatherApi.forecastAPIQuery)\(endpoint)")
        
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: Constants.WeatherApi.weatherAPIKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        
        return components?.url
    }
}
