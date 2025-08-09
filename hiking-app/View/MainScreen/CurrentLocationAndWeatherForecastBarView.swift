import SwiftUI
import Kingfisher

struct CurrentLocationAndWeatherForecastBarView: View {
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var weatherViewModel: WeatherForecastViewModel
    
    @State private var showFiveDayForecast = false
    
    var body: some View {
        HStack{
            Image(systemName: "location.north.circle")
                .resizable()
                .frame(width: 30, height: 30)
            Text(locationManager.cityName)
            
            Spacer()
            
            if let weather = weatherViewModel.currentWeather,
               let iconURL = weather.currentForecastIconURL {
                
                HStack {
                    Text("\(weather.main.roundedTemp)°")
                    
                    KFImage(iconURL)
                        .cacheOriginalImage()
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
        }
        .onAppear {
            weatherViewModel.getCurrentForecast(city: locationManager.cityName)
            print(locationManager.cityName)
        }
        .onTapGesture {
            showFiveDayForecast = true
        }
        .sheet(isPresented: $showFiveDayForecast) {
            ForecastDetailView(
                showFiveDayForecast: $showFiveDayForecast,
                forecast: weatherViewModel.forecast,
                currentLocation: locationManager.cityName
            )
        }
        .padding()
        .frame(width: 350, height: 70)
    }
}

#Preview {
    CurrentLocationAndWeatherForecastBarView(weatherViewModel: WeatherForecastViewModel())
}

struct ForecastDetailView: View {
    @Binding var showFiveDayForecast: Bool
    let forecast: [ForecastEntry]
    let currentLocation: String
    
    var body: some View {
        NavigationView {
            ScrollView(.horizontal) {
                HStack() {
                    ForEach(forecast.prefix(40), id: \.dt) { entry in
                        VStack(alignment: .leading) {
                            Text("\(entry.localizedDayOfWeek) \(entry.timeString)")
                                .font(.headline)
                            Text("🌡 \(entry.main.temp, specifier: "%.0f") °C")
                                .font(.subheadline)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .frame(width: 140)
                    }
                }
            }
            .navigationTitle("Прогноз на \(currentLocation)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Закрити") {
                        showFiveDayForecast = false
                    }
                }
            }
        }
    }
}
