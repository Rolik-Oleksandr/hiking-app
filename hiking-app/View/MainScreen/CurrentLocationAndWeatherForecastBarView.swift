import SwiftUI

struct CurrentLocationAndWeatherForecastBarView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var weatherViewModel: WeatherForecastViewModel
    
    var body: some View {
        HStack{
            Image(systemName: "location.north.circle")
                .resizable()
                .frame(width: 30, height: 30)
            Text(locationManager.cityName)
            
            Spacer()
            
            if let weather = weatherViewModel.currentWeather,
               let iconURL = weather.iconURL {
                
                HStack {
                    Text("\(weather.main.roundedTemp)°")
                    
                    AsyncImage(url: iconURL) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 50, height: 50)
                        case .failure:
                            Image(systemName: "questionmark.circle")
                        case .empty:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
            }
        }
        .onAppear {
            weatherViewModel.getCurrentForecast(city: locationManager.cityName)
            print(locationManager.cityName)
        }
        .padding()
        .frame(width: 350, height: 70)
    }
}

#Preview {
    CurrentLocationAndWeatherForecastBarView(weatherViewModel: WeatherForecastViewModel())
}
