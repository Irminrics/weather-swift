//
//  CityView.swift
//  WeatherApp
//
//  Created by Jun Kang on 4/8/21.
//

import SwiftUI

struct CityView: View {
    @AppStorage("favouritesCity") var favouritesCity: [String] = []
    @AppStorage("favouritesTimezone") var favouritesTimezone: [Int] = []
    @AppStorage("favouritesTemp") var favouritesTemp: [Double] = []
    @AppStorage("favouritesMainWeather") var favouritesMainWeather: [String] = []
    @AppStorage("favouritesIcon") var favouritesIcon: [String] = []

    var currentGlobalTime = Date().toGlobalTime()
    
    var body: some View {
        //NavigationView {
        ZStack {
            VStack {
                
                Spacer()
                
                Text("Choose a City")
                    .frame(width: 300, height: 80)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color("darkblue"))
                    .multilineTextAlignment(.center)
                
                
                Text("Select a city or country to see the weather")
                    .frame(width: 250, height:50, alignment: .center)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                
                
                Button("Add the City to favourite"){
                    deleteAllWeathers()
                    getWeatherData(city: "Singapore")
                    getWeatherData(city: "China")
                    getWeatherData(city: "Europe")
                    getWeatherData(city: "Australia")
                    getWeatherData(city: "London")
                    
                }
                .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .font(.system(size:16, weight: .bold))
                .background(Color.yellow)
                .foregroundColor(Color("darkblue"))
                .cornerRadius(15)
                
                
                
                HStack {
                    Text("My Weather")
                        .frame(width: 380, height: 30, alignment: .leading)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color("darkblue"))
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                }
                
                
                ScrollView (showsIndicators: false) {
                    VStack(spacing: 10) {
                        
                        //MainCityWeatherView(city: "Singapore", temperature: 36.0, icon: "01d", color: "afternoon1")
                        
                        List {
                            
                            if(favouritesCity.count > 0) {
                                ForEach((0..<1), id: \.self) { favIndex in
                                    MainCityWeatherView(city: favouritesCity[favIndex],
                                                        temperature: favouritesTemp[favIndex],
                                                        icon: favouritesIcon[favIndex],
                                                        color: convertTimeToColor(time: currentGlobalTime.toLocalTime(secondsFromGMT: favouritesTimezone[favIndex]).toTimeFormat().replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)),
                                                        textColor: getTextColour(time: currentGlobalTime.toLocalTime(secondsFromGMT: favouritesTimezone[favIndex]).toTimeFormat().replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)))
                                        .swipeActions(allowsFullSwipe: false) {
                                            Button(role: .destructive) {
                                                deleteWeather(with: favIndex)
                                            } label: {
                                                Label("", systemImage: "trash")
                                            }
                                        }
                                        .listRowSeparator(.hidden)
                                }
                            }
                            
                            if(favouritesCity.count > 1) {
                                ForEach((1..<favouritesCity.count), id: \.self) { favIndex in
                                    CityWeatherView(city: favouritesCity[favIndex],
                                                    timezone: favouritesTimezone[favIndex],
                                                    temperature: favouritesTemp[favIndex],
                                                    color: convertTimeToColor(time: currentGlobalTime.toLocalTime(secondsFromGMT: favouritesTimezone[favIndex]).toTimeFormat().replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)),
                                                    textColor: getTextColour(time: currentGlobalTime.toLocalTime(secondsFromGMT: favouritesTimezone[favIndex]).toTimeFormat().replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)))
                                        .swipeActions(allowsFullSwipe: false) {
                                            Button(role: .destructive) {
                                                deleteWeather(with: favIndex)
                                            } label: {
                                                Label("", systemImage: "trash.fill")
                                            }
                                        }
                                        .swipeActions(edge: .leading ,allowsFullSwipe: false) {
                                            Button(role: .destructive) {
                                                makeMainWeather(with: favIndex)
                                            } label: {
                                                Label("", systemImage: "star.fill")
                                            }
                                            .tint(Color.yellow)
                                        }
                                        .listRowSeparator(.hidden)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .frame(width: 430, height: 530, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
                .frame(width: 390, height: 530)
                
                
                Text("Powered by OpenWeather API")
                    .frame(width: 250, height:40, alignment: .center)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
            }
            .padding(.top, 40)
            
        }
        .ignoresSafeArea()
        
        
        //}
    }
    
    func getTextColour(time: String) -> Color {
        let intTime = Int(time) ?? 0
        
        if (1900 <= intTime && intTime <= 2400) || (0000 <= intTime && intTime <= 0600) {
            return Color.white
        }
        else {
            return Color.black
        }
        
    }
    
    
    func makeMainWeather(with index: Int) {
        favouritesCity.swapAt(0, index)
        favouritesTimezone.swapAt(0, index)
        favouritesTemp.swapAt(0, index)
        favouritesMainWeather.swapAt(0, index)
        favouritesIcon.swapAt(0, index)
    }
    
    func deleteWeather(with index: Int) {
        favouritesCity.remove(at: index)
        favouritesTimezone.remove(at: index)
        favouritesTemp.remove(at: index)
        favouritesMainWeather.remove(at: index)
        favouritesIcon.remove(at: index)
    }
    
    
    func deleteAllWeathers() {
        favouritesCity.removeAll()
        favouritesTimezone.removeAll()
        favouritesTemp.removeAll()
        favouritesMainWeather.removeAll()
        favouritesIcon.removeAll()
    }
    
    func getWeatherData(city: String) {
        //convert string url to swift url
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=b4656ed1180f72efa00dbb397a127ef8&units=metric"
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
                        self.favouritesCity.append(decodedData.name)
                        self.favouritesTimezone.append(decodedData.timezone)
                        self.favouritesTemp.append(decodedData.main.temp)
                        self.favouritesMainWeather.append(decodedData.weather[0].mainWeather)
                        self.favouritesIcon.append(decodedData.weather[0].icon)
                    } catch {
                        print("Error! Something went wrong.")
                    }
                }
            }
        }.resume()
        
    }
    
    func convertTimeToColor(time: String) -> String {
        let intTime = Int(time) ?? 0
        
        if (0300 <= intTime &&  intTime < 0400) {
            return "midnight1"
        }
        
        else if (0400 <= intTime &&  intTime < 0500) {
            return "midnight2"
        }
        
        else if (0500 <= intTime &&  intTime < 0600) {
            return "midnight3"
        }
        
        else if (0600 <= intTime &&  intTime < 0700) {
            return "midnight4"
        }
        
        else if (0700 <= intTime &&  intTime < 0800) {
            return "morning1"
        }
        
        else if (0800 <= intTime &&  intTime < 1000) {
            return "morning2"
        }
        
        else if (1000 <= intTime &&  intTime < 1100) {
            return "morning3"
        }
        else if (1100 <= intTime &&  intTime < 1200) {
            return "morning4"
        }
        else if (1200 <= intTime &&  intTime < 1300) {
            return "afternoon1"
        }
        
        else if (1300 <= intTime &&  intTime < 1400) {
            return "afternoon2"
        }
        else if (1400 <= intTime &&  intTime < 1500) {
            return "afternoon3"
        }
        else if (1500 <= intTime &&  intTime < 1700) {
            return "evening1"
        }
        
        else if (1700 <= intTime &&  intTime < 1900) {
            return "evening2"
        }
        else if (1900 <= intTime &&  intTime < 2000) {
            return "night1"
        }
        else if (2000 <= intTime &&  intTime < 2100) {
            return "night2"
        }
        
        else if (2100 <= intTime &&  intTime < 2200) {
            return "night3"
        }
        else if (2200 <= intTime &&  intTime < 2300) {
            return "night4"
        }
        else  {
            return "night5"
        }
    }
    
    func convertWeatherToIcon(weather: String) -> String {
        if (weather == "Clear") {
            return "sun.max.fill"
        }
        
        else if (weather == "Clouds") {
            return "cloud.fill"
        }
        
        else if (weather == "Rain") {
            return "cloud.heavyrain.fill"
        }
        else if (weather == "Snow") {
            return "snowflake"
        }
        else if (weather == "Drizzle") {
            return "cloud.drizzle.fill"
        }
        else if (weather == "Thunderstorm") {
            return "cloud.bolt.rain.fill"
        }
        else {
            return ""
        }
    }
    
}


struct CityWeatherView: View {
    var city: String
    var timezone: Int
    var temperature: Double
    var color: String
    var textColor: Color
    var body: some View {
        NavigationLink (
            destination: CityView(),
            label: {
                HStack {
                    VStack(alignment: .leading) {
                        HStack{Spacer()}
                        Text("\(city)")
                            .foregroundColor(textColor)
                            .font(.system(size: 35))
                        
                        Text("\(Date().toGlobalTime().toLocalTime(secondsFromGMT: timezone).toTimeFormat())")
                            .foregroundColor(textColor)
                        
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    VStack{
                        Text("\(Int(temperature))°")
                            .foregroundColor(textColor)
                            .font(.system(size: 70, weight: .bold))
                    }
                    .padding(.trailing, 15)
                    
                }
                .frame(width: 390, height: 120)
                .background(Color("\(color)"))
                .cornerRadius(15)
            })
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct MainCityWeatherView: View {
    var city: String
    var temperature: Double
    var icon: String
    var color: String
    var textColor: Color
    var body: some View {
        NavigationLink (
            destination: CityView(),
            label: {
                HStack{
                    VStack(alignment: .leading) {
                        
                        Image("\(icon)")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115, height: 115, alignment: .leading)
                            .padding()
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            Text("\(city)")
                                .foregroundColor(textColor)
                                .font(.system(size: 35))
                            
                            Text("My current location")
                                .foregroundColor(textColor)
                                .font(.system(size: 22, weight: .light))
                        }
                        .padding(.bottom, 28)
                        .padding(.leading, 5)
                    }
                    
                    VStack{
                        Spacer()
                        Text("\(Int(temperature))°")
                            .frame(width: 150, alignment: .trailing)
                            .foregroundColor(textColor)
                            .font(.system(size: 70, weight: .bold))
                            .padding(.leading, 20)
                            .padding(.bottom, 15)
                    }
                }
                .frame(width: 390, height: 250)
                .font(.system(size: 20, weight: .bold))
                .background(Color("\(color)"))
                .cornerRadius(15)
            })
    }
}
