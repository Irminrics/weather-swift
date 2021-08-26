//
//  AddView.swift
//  AddView
//
//  Created by Jun Kang on 23/8/21.
//

import SwiftUI

struct SheetView: View {
    @AppStorage("favouritesCity") var favouritesCity: [String] = []
    @AppStorage("favouritesTime") var favouritesTime: [String] = []
    @AppStorage("favouritesTemp") var favouritesTemp: [Double] = []
    @AppStorage("favouritesMainWeather") var favouritesMainWeather: [String] = []
    @AppStorage("favouritesIcon") var favouritesIcon: [String] = []
    @AppStorage("cityData") var cityData: [String] = []
    @Environment(\.dismiss) var dismiss
    @State private var searchQuery: String = ""
    @State private var isSearching = false
    var cp = CountryPool();
    
    var body: some View {
        ZStack{
            Color("lightgray")
                .ignoresSafeArea()
            VStack{
                
                
                VStack {
                    HStack {
                        Button(action: {}, label: {
                            Image(systemName: "globe")
                                .padding(5)
                        })
                            .background(Color.white)
                            .font(.system(size: 18))
                            .cornerRadius(12)
                            .padding(.leading, 30)
                        
                        Spacer()
                        
                        Text(Date().toDayFormat())
                            .font(Font.custom("Montserrat-Regular", size: 20))
                        
                        Spacer()
                        
                        Button(action: {dismiss()}, label: {
                            Image(systemName: "xmark")
                                .padding(6)
                        })
                            .foregroundColor(Color.red)
                            .background(Color.white)
                            .font(.system(size: 18))
                            .cornerRadius(12)
                            .padding(.trailing, 30)
                    }
                    .padding(.top, 35)
                    .padding(.bottom, 25)
                }
                
                VStack{
                    Text("Enter your desired country")
                        .font(Font.custom("Montserrat-Regular", size: 18))
                }
                
                
                VStack{
                    HStack{
                        HStack {
                            TextField(" Search country", text: $searchQuery)
                                .padding(.leading, 35)
                                .disableAutocorrection(true)
                        }
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(15)
                        .onTapGesture {
                            isSearching = true
                        }
                        .overlay(
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Spacer()
                            }
                                .padding(.horizontal, 10)
                                .foregroundColor(.gray)
                        )
                        
                        if isSearching && searchQuery != "" {
                            Button(action: {
                                isSearching = false
                                searchQuery = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                            }, label: {
                                Text("Cancel")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                    .padding(.trailing)
                                    .padding(.leading, 5)
                            })
                                .transition(.move(edge: .trailing))
                                .animation(.spring(), value: false)
                        }
                    }
                    .padding(20)
                }
                
                Spacer()
                
                VStack {
                    ScrollView (showsIndicators: false) {
                        VStack(spacing: 10){
                            
                            ForEach((0..<cp.countries.count).filter({"\(cp.countries[$0])".contains(searchQuery) || searchQuery.isEmpty}), id: \.self) { index in
                                HStack {
                                    Text("\(cp.countries[index])")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                        .padding(.leading, 24)
                                    Spacer()
                                }
                                .padding()
                                .background(Color("gray"))
                                .cornerRadius(15)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    getWeatherData(city: cp.countries[index])
                                    dismiss()
                                }
                                
                            }
                            
                        }
                    }
                }
                //.onAppear{getAllData()}
            }
        }
    }
    
    func getWeatherData(city: String) {
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
    
    
    func getAllData() {
        //convert string url to swift url
        let path = Bundle.main.path(forResource: "city", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        cityData.removeAll()
        
        
        //use to connect to api; either get data, response or error
        //use _ if u do not need it
        URLSession.shared.dataTask(with: url) {data, _, error in
            //telling the machine this is an async operation so might have to wait
            DispatchQueue.main.async {
                //if we get an actual data
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(Welcome.self, from: data)
                        for cities in 0...10 {self.cityData.append(decodedData[cities].name ?? "")}
                    } catch let jsonError as NSError {
                        print("JSON decode failed: \(jsonError.localizedDescription)")
                      }
                }
            }
        }.resume()
        
    }
    
    
}
