//
//  CityView.swift
//  WeatherApp
//
//  Created by Jun Kang on 4/8/21.
//
import SwiftUI



struct CityView: View {
    @AppStorage("favouritesCity") var favouritesCity: [String] = []
    @AppStorage("favouritesTime") var favouritesTime: [String] = []
    @AppStorage("favouritesTemp") var favouritesTemp: [Double] = []
    @AppStorage("favouritesMainWeather") var favouritesMainWeather: [String] = []
    @AppStorage("favouritesIcon") var favouritesIcon: [String] = []
    @State var searchQuery: String = ""
    @State var isSearching = false
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Choose a City")
                    .frame(width: 300, height: 40)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color("darkblue"))
                    .multilineTextAlignment(.center)
                
                
                Text("Select a country to see the weather")
                    .frame(width: 250, height:50, alignment: .center)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                HStack {
                    TextField(" Search country", text: $searchQuery)
                        .padding(.leading, 24)
                        .padding(.trailing, 24)
                }
                .frame(width: 355, height: 50)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .background(Color("lightgray"))
                .cornerRadius(15)
                .onTapGesture {
                    isSearching = true
                }
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Spacer()
                        if (isSearching) {
                            Button(action: {searchQuery = ""}, label: {
                                Image(systemName: "xmark.circle.fill")
                                    .padding(.vertical)
                            })
                        }
                    }
                        .padding(.horizontal, 10)
                        .foregroundColor(.gray)
                )
                
                //                                        Button("Add the City to favourite"){
                //
                //                                            deleteAllWeathers()
                //                                            getWeatherData(city: "Singapore")
                //                                            getWeatherData(city: "China")
                //                                            getWeatherData(city: "Europe")
                //                                            getWeatherData(city: "Australia")
                //                                            getWeatherData(city: "London")
                //
                //                                        }
                //                                        .frame(width: 280, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //                                        .font(.system(size:16, weight: .bold))
                //                                        .background(Color.yellow)
                //                                        .foregroundColor(Color("darkblue"))
                //                                        .cornerRadius(15)
                
                VStack {
                    HStack {
                        Text("My Weather")
                            .frame(width: 380, height: 20, alignment: .leading)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("darkblue"))
                            .padding(.top, 5)
                    }
                    ScrollView (showsIndicators: false) {
                        VStack(spacing: 10){
                            
                            //MainCityWeatherView(city: "Singapore", temperature: 39.0, icon: "01d", color: "midnight1", textColor: Color.white)
                            
                            List {
                                if(favouritesCity.count > 0) {
                                    ForEach((0..<1).filter({"\(favouritesCity[$0])".contains(searchQuery) || searchQuery.isEmpty}), id: \.self) { favIndex in
                                        MainCityWeatherView(city: favouritesCity[favIndex],
                                                            temperature: favouritesTemp[favIndex],
                                                            icon: favouritesIcon[favIndex],
                                                            color: convertTimeToColor(time: favouritesTime[favIndex]),
                                                            textColor: getTextColour(time: favouritesTime[favIndex]))
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
                                    ForEach((1..<favouritesCity.count).filter({"\(favouritesCity[$0])".contains(searchQuery) || searchQuery.isEmpty}), id: \.self) { favIndex in
                                        CityWeatherView(city: favouritesCity[favIndex],
                                                        time: favouritesTime[favIndex],
                                                        temperature: favouritesTemp[favIndex],
                                                        color: convertTimeToColor(time: favouritesTime[favIndex]),
                                                        textColor: getTextColour(time: favouritesTime[favIndex]))
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
                                
                                
                                
                                //list
                            }
                            .listStyle(PlainListStyle())
                            .frame(width: 430, height: 525, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            
                            
                            
                        }
                        //scrollview
                    }
                    .frame(width: 430, height: 525)
                    
                    
                    Spacer()
                    
                    Text("Powered by OpenWeather API")
                        .frame(width: 250, height:15, alignment: .center)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    
                }
            }
            .offset(y: -25)
            
        }
        .ignoresSafeArea(.keyboard)
        .onAppear{updateWeatherData()}
        .onReceive(timer) { time in
            updateWeatherData()
        }
    }
    
    
    func updateWeatherData() {
        
        for (index,city) in favouritesCity.enumerated() {
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
    
    func getTextColour(time: String) -> Color {
        let filteredTime = time.replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)
        let intTime = Int(filteredTime) ?? 0
        
        if (1900 <= intTime && intTime <= 2400) || (0000 <= intTime && intTime <= 0600) {
            return Color.white
        }
        else {
            return Color.black
        }
        
    }
    
    
    func makeMainWeather(with index: Int) {
        favouritesCity.swapAt(0, index)
        favouritesTime.swapAt(0, index)
        favouritesTemp.swapAt(0, index)
        favouritesMainWeather.swapAt(0, index)
        favouritesIcon.swapAt(0, index)
    }
    
    func deleteWeather(with index: Int) {
        favouritesCity.remove(at: index)
        favouritesTime.remove(at: index)
        favouritesTemp.remove(at: index)
        favouritesMainWeather.remove(at: index)
        favouritesIcon.remove(at: index)
    }
    
    
    func deleteAllWeathers() {
        favouritesCity.removeAll()
        favouritesTime.removeAll()
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
                        self.favouritesTime.append(Date().toGlobalTime().toLocalTime(secondsFromGMT: decodedData.timezone).toTimeFormat())
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
        let filteredTime = time.replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)
        let intTime = Int(filteredTime) ?? 0
        
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
    
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}
