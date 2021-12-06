//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jun Kang on 4/8/21.
//

import SwiftUI

struct StartView: View {
    @AppStorage("favouritesCity") var favouritesCity: [String] = []
    @AppStorage("favouritesTime") var favouritesTime: [String] = []
    @AppStorage("favouritesDate") var favouritesDate: [Date] = []
    @AppStorage("favouritesTemp") var favouritesTemp: [Double] = []
    @AppStorage("favouritesMainWeather") var favouritesMainWeather: [String] = []
    @AppStorage("favouritesIcon") var favouritesIcon: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color("skyblue")
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Image("weather-icon")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.top, 70)
                    
                    Spacer()
                    
                    Text("Just another weather app")
                        .frame(width: 300, height: 200)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color("darkblue"))
                        .multilineTextAlignment(.center)
                    
                    Text("Powered by OpenWeather API")
                        .frame(width: 250, height:70, alignment: .center)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink (
                        destination: CityView(),
                        label: {
                            Text("Get Started")
                                .frame(width: 250, height: 50)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("darkblue"))
                                .background(Color.yellow)
                                .cornerRadius(12)
                                .padding(.bottom, 100)
                        }).onAppear{updateWeatherData()}
                }
            }
            
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    
    func deleteAllWeathers() {
        favouritesCity.removeAll()
        favouritesTime.removeAll()
        favouritesDate.removeAll()
        favouritesTemp.removeAll()
        favouritesMainWeather.removeAll()
        favouritesIcon.removeAll()
    }
    
    func updateWeatherData() {
        
        for (index,city) in favouritesCity.enumerated() {
            let filteredCity = city.replacingOccurrences(of: " ", with: "%20")
            //convert string url to swift url
            let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(filteredCity)&appid=b4656ed1180f72efa00dbb397a127ef8&units=metric"
            let url = URL(string: urlString)
            
            //use to connect to api; either get data, response or error
            //use _ if u do not need it
            URLSession.shared.dataTask(with: url!) {data, _, error in
                //telling the machine this is an async operation so might have to wait
                DispatchQueue.main.async {
                    //if we get an actual data
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode(WeatherData.self, from: data)
                            self.favouritesCity[index] = decodedData.name
                            self.favouritesTime[index] = Date().toGlobalTime().toLocalTime(secondsFromGMT: decodedData.timezone).toTimeFormat()
                            self.favouritesTemp[index] = decodedData.main.temp
                            self.favouritesMainWeather[index] = decodedData.weather[0].mainWeather
                            self.favouritesIcon[index] = decodedData.weather[0].icon
                        } catch {
                            print("Error! Something went wrong.")
                        }
                    }
                }
            }.resume()
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
