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
    @AppStorage("favouritesDate") var favouritesDate: [Date] = []
    @AppStorage("favouritesTemp") var favouritesTemp: [Double] = []
    @AppStorage("favouritesMainWeather") var favouritesMainWeather: [String] = []
    @AppStorage("favouritesIcon") var favouritesIcon: [String] = []
    @State private var showingSheet = false
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            
            Color("lightgray")
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                VStack {
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "globe")
                                .padding(5)
                        })
                            .foregroundColor(Color.yellow)
                            .background(Color.white)
                            .font(.system(size: 18))
                            .cornerRadius(12)
                            .padding(.leading, 30)
                        
                        Spacer()
                        
                        Text(Date().toDayFormat())
                            .font(Font.custom("Montserrat-Regular", size: 20))
                        
                        Spacer()
                        
                        Button(action: {showingSheet.toggle()}, label: {
                            Image(systemName: "plus")
                                .padding(6)
                        })
                            .sheet(isPresented: $showingSheet) {
                                SheetView()
                            }
                            .foregroundColor(Color.black)
                            .background(Color.white)
                            .font(.system(size: 18))
                            .cornerRadius(12)
                            .padding(.trailing, 30)
                    }
                    .padding(.bottom, 10)
                    .background(Color("lightgray"))
                }
                
                VStack{
                    ScrollView (showsIndicators: false) {
                        VStack(spacing: 10){
                            List {
                                
                                if(favouritesCity.count > 0) {
                                    ForEach((0..<1), id: \.self) { favIndex in
                                        MainCityWeatherView(city: favouritesCity[favIndex],
                                                            date: favouritesDate[favIndex],
                                                            temperature: favouritesTemp[favIndex],
                                                            
                                                            icon: favouritesIcon[favIndex],
                                                            color: convertTimeToColor(time: favouritesTime[favIndex]),
                                                            textColor: getTextColour(time: favouritesTime[favIndex]))
                                            .swipeActions() {
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
                                                        date: favouritesDate[favIndex],
                                                        temperature: favouritesTemp[favIndex],
                                                        color: convertTimeToColor(time: favouritesTime[favIndex]),
                                                        textColor: getTextColour(time: favouritesTime[favIndex]),
                                                        icon: favouritesIcon[favIndex])
                                            .swipeActions() {
                                                Button(role: .destructive) {
                                                    deleteWeather(with: favIndex)
                                                } label: {
                                                    Label("", systemImage: "trash.fill")
                                                }
                                            }
                                            .swipeActions(edge: .leading) {
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
                            }//list
                            .frame(width: 430, height: 655, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .listRowBackground(Color("lightgray"))
                            .listStyle(PlainListStyle())
                        }
                    } //scrollview
                    .frame(width: 430, height: 655, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                Spacer()

                VStack {
                    Text("Powered by OpenWeather API")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color("lightgray"))
        .onAppear{updateWeatherData()}
        .onReceive(timer) { time in
            updateWeatherData()
        }
        
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
                            self.favouritesDate[index] = Date().toGlobalTime().toLocalTime(secondsFromGMT: decodedData.timezone)
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
    
    func refreshWeatherData() {
        
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
                            self.favouritesDate[index] = Date().toGlobalTime().toLocalTime(secondsFromGMT: decodedData.timezone)
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
        
        if (2200 <= intTime && intTime <= 2400) || (0000 <= intTime && intTime < 0500) {
            return Color.white
        }
        else {
            return Color.black
        }
        
    }
    
    
    func makeMainWeather(with index: Int) {
        favouritesCity.swapAt(0, index)
        favouritesTime.swapAt(0, index)
        favouritesDate.swapAt(0, index)
        favouritesTemp.swapAt(0, index)
        favouritesMainWeather.swapAt(0, index)
        favouritesIcon.swapAt(0, index)
    }
    
    func deleteWeather(with index: Int) {
        favouritesCity.remove(at: index)
        favouritesTime.remove(at: index)
        favouritesDate.remove(at: index)
        favouritesTemp.remove(at: index)
        favouritesMainWeather.remove(at: index)
        favouritesIcon.remove(at: index)
    }
    
    
    func deleteAllWeathers() {
        favouritesCity.removeAll()
        favouritesTime.removeAll()
        favouritesDate.removeAll()
        favouritesTemp.removeAll()
        favouritesMainWeather.removeAll()
        favouritesIcon.removeAll()
    }
    
    func convertTimeToColor(time: String) -> String {
        let filteredTime = time.replacingOccurrences(of: ":", with: "", options: NSString.CompareOptions.literal, range: nil)
        let intTime = Int(filteredTime) ?? 0
        
        if (0500 <= intTime &&  intTime < 0800) {
            return "midnight"
        }
        else if (0800 <= intTime &&  intTime < 1300) {
            return "morning"
        }
        
        else if (1300 <= intTime &&  intTime < 1900) {
            return "afternoon"
        }
        else if (1900 <= intTime &&  intTime < 2200) {
            return "evening"
        }
        else  {
            return "night"
        }
    }
    
    
}


struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView()
    }
}


