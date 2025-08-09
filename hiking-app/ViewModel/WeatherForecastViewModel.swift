import Foundation
import Combine
import CoreLocation

class WeatherForecastViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var forecast: [ForecastEntry] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let forecastService: WeatherForecastService
    private var cancellables = Set<AnyCancellable>()
    
    init(forecastService: WeatherForecastService = WeatherForecastService()) {
        self.forecastService = forecastService
    }
    
    func getCurrentForecast(city: String) {
        isLoading = true
        errorMessage = nil
        
        forecastService.fetchCurrentForecast(city: city)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] weather in
                self?.currentWeather = weather
            }
            .store(in: &cancellables)
    }
    
    func get5DayForecast(city: String) {
        isLoading = true
        errorMessage = nil
        
        forecastService.fetch5DaysForecast(city: city)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] forecast in
                self?.forecast = forecast.list
            }
            .store(in: &cancellables)
    }
}
