//
//  DetailedCityView.swift
//  DetailedCityView
//
//  Created by Jun Kang on 26/8/21.
//

import SwiftUI

struct DetailedCityView: View {
    var city: String
    var temperature: Double
    var icon: String
    var bgColor: String
    var fontColor: Color
    var time: Date
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State var mainWeather = ""
    @State var feelsLike = 0.0
    @State var tempMax = 0.0
    @State var tempMin = 0.0
    @State var lat: Double = 0.0
    @State var lon: Double = 0.0
    @State var tempMaxForecast: [Double] = [0, 0, 0, 0, 0, 0]
    @State var tempMinForecast: [Double] = [0, 0, 0, 0, 0, 0]
    var body: some View {
        ZStack{
            ScrollView {
                VStack {
                    VStack{
                        HStack {
                            NavigationLink (
                                destination: CityView(),
                                label: {
                                    Image(systemName: "chevron.backward")
                                        .padding(.top, 5)
                                        .padding(.leading, 9)
                                        .padding(.trailing, 9)
                                        .padding(.bottom, 5)
                                        .foregroundColor(Color.red)
                                        .background(Color.white)
                                        .font(.system(size: 18))
                                        .cornerRadius(12)
                                        .padding(.leading, 30)
                                    
                                })
                            
                            Spacer()
                            
                            Text(time.toDayFormat())
                                .font(Font.custom("Montserrat-Regular", size: 20))
                                .foregroundColor(fontColor)
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "plus")
                                    .padding(6)
                            })
                                .foregroundColor(Color.black)
                                .background(Color.white)
                                .font(.system(size: 18))
                                .cornerRadius(12)
                                .padding(.trailing, 30)
                        }
                        .padding(.bottom, 10)
                        .background(Color("\(bgColor)"))
                    }
                    
                    //icon
                    HStack{
                        Spacer()
                        Image("\(icon)")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200, alignment: .leading)
                            .padding()
                        Spacer()
                    }
                    
                    
                    VStack {
                        
                        HStack{
                            Text("\(Int(round(temperature)))°")
                            //.foregroundColor("textColor")
                                .font(.system(size: 90, weight: .bold))
                                .foregroundColor(fontColor)
                            Spacer()
                        }
                        
                        HStack{
                            Text("\(city)")
                                .font(Font.custom("Montserrat-Regular", size: 40))
                                .foregroundColor(fontColor)
                            Spacer()
                        }
                        .padding(.bottom, 1)
                        
                        HStack{
                            Text("\(mainWeather) | H: \(Int(round(tempMax))) L: \(Int(round(tempMin))) | feels like \(Int(round(feelsLike)))")
                                .font(Font.custom("Montserrat-Regular", size: 20))
                                .foregroundColor(fontColor)
                            Spacer()
                        }
                    }
                    .padding(.top, -20)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                .padding(.top, 70)
                
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .background(Color("\(bgColor)"))
                
                
                ZStack {
                    VStack (spacing: 0) {
                        VStack {
                            HStack{
                                Spacer()
                            }
                        }
                        .frame(height: 65)
                        .background(Color("\(bgColor)"))
                        VStack {
                            HStack{
                                Spacer()
                            }
                        }
                        .frame(height: 65)
                    }
                    
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack (spacing: 15.5) {
                            VStack {
                                ZStack {
                                    Image("\(icon)")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35, alignment: .leading)
                                        .padding()
                                    
                                    VStack {
                                        Text("Now")
                                            .font(Font.custom("Montserrat-Bold", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("\(Int(round(temperature)))°")
                                            .font(Font.custom("Montserrat-Bold", size: 18))
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                ZStack {
                                    Image("\(icon)")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35, alignment: .leading)
                                        .padding()
                                    
                                    VStack {
                                        Text(Calendar.current.date(byAdding: .day, value: 1, to: time)!.toDayNumberFormat())
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("\(Int(round((tempMinForecast[0] + tempMaxForecast[0])/2)))°")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                ZStack {
                                    Image("\(icon)")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35, alignment: .leading)
                                        .padding()
                                    
                                    VStack {
                                        Text(Calendar.current.date(byAdding: .day, value: 2, to: time)!.toDayNumberFormat())
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("\(Int(round((tempMinForecast[1] + tempMaxForecast[1])/2)))°")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                ZStack {
                                    Image("\(icon)")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35, alignment: .leading)
                                        .padding()
                                    
                                    VStack {
                                        Text(Calendar.current.date(byAdding: .day, value: 3, to: time)!.toDayNumberFormat())
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("\(Int(round((tempMinForecast[2] + tempMaxForecast[2])/2)))°")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                ZStack {
                                    Image("\(icon)")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 35, height: 35, alignment: .leading)
                                        .padding()
                                    
                                    VStack {
                                        Text(Calendar.current.date(byAdding: .day, value: 4, to: time)!.toDayNumberFormat())
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("\(Int(round((tempMinForecast[3] + tempMaxForecast[3])/2)))°")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.bottom, 10)
                                    }
                                }
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width-50, alignment: .center)
                    
                }
                
                
                
                
                HStack {
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 0) {
                            HStack {
                                Text(Calendar.current.date(byAdding: .day, value: 1, to: time)!.toDayNameFormat())
                                    .frame(width: 110, alignment: .leading)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Image("\(icon)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[0])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMaxForecast[0])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            
                            HStack {
                                Text(Calendar.current.date(byAdding: .day, value: 2, to: time)!.toDayNameFormat())
                                    .frame(width: 110, alignment: .leading)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                
                                Spacer()
                                
                                Image("\(icon)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[1])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[1])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            HStack {
                                Text(Calendar.current.date(byAdding: .day, value: 3, to: time)!.toDayNameFormat())
                                    .frame(width: 110, alignment: .leading)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                
                                Spacer()
                                
                                Image("\(icon)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[2])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMaxForecast[2])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            HStack {
                                Text(Calendar.current.date(byAdding: .day, value: 4, to: time)!.toDayNameFormat())
                                    .frame(width: 110, alignment: .leading)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                
                                Spacer()
                                
                                Image("\(icon)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[3])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMaxForecast[3])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            HStack {
                                Text(Calendar.current.date(byAdding: .day, value: 5, to: time)!.toDayNameFormat())
                                    .frame(width: 110, alignment: .leading)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                
                                Spacer()
                                
                                Image("\(icon)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[4])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMaxForecast[4])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            HStack {
                                Text(Calendar.current.date(byAdding: .day, value: 6, to: time)!.toDayNameFormat())
                                    .frame(width: 110, alignment: .leading)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                
                                Spacer()
                                
                                Image("\(icon)")
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35, alignment: .leading)
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMinForecast[5])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                                
                                Spacer()
                                
                                Text("\(Int(round(tempMaxForecast[5])))°")
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                    }
                }
                .frame(width: UIScreen.main.bounds.width-50,height: UIScreen.main.bounds.height-700, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                
                
                HStack {
                    Spacer()
                    VStack {
                        Text("Today")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(Font.custom("Montserrat-Bold", size: 20))
                            .padding(.leading, 10)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        
                        VStack {
                            
                            HStack {
                                VStack {
                                    Text("Sunrise")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("06:52")
                                        .font(Font.custom("Montserrat-Bold", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                Spacer()
                                VStack {
                                    Text("Noon")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                    Text("13:29")
                                        .font(Font.custom("Montserrat-Bold", size: 18))
                                }
                                Spacer()
                                VStack {
                                    Text("Sunset")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    Text("17:27")
                                        .font(Font.custom("Montserrat-Bold", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            .padding(.leading, 10)
                            .padding(.trailing, 15)
                            
                            Image("sunline")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .offset(y: -15)
                                .padding(.leading, 2)
                                .padding(.trailing, 8)
                            
                            HStack {
                                VStack {
                                    Text("Snow")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                    Spacer()
                                    Image("snow")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Spacer()
                                    Text("10%")
                                        .font(Font.custom("Montserrat-Bold", size: 18))
                                    Spacer()
                                }
                                Spacer()
                                VStack {
                                    Text("Humidity")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                    Spacer()
                                    Image("humidity")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Spacer()
                                    Text("62%")
                                        .font(Font.custom("Montserrat-Bold", size: 18))
                                    Spacer()
                                }
                                Spacer()
                                VStack {
                                    Text("Wind")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                    Spacer()
                                    Image("wind")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50, alignment: .center)
                                    Spacer()
                                    Text("5m/s")
                                        .font(Font.custom("Montserrat-Bold", size: 18))
                                    Spacer()
                                }
                            }
                            .padding(.leading, 35)
                            .padding(.trailing, 40)
                            
                            
                            
                        }
                        
                        
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.height-550)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 10)
                .padding(.bottom, 30)
                
            }
            
            
            
        }
        .background(Color("lightgray"))
        .ignoresSafeArea()
        .onAppear{updateWeatherData(); updateWeatherForecastData()}
        .onReceive(timer) { time in
            updateWeatherData()
            updateWeatherForecastData()
        }
        
    }
    
    
    func updateWeatherData() {
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
                        feelsLike = decodedData.main.feels_like
                        tempMax = decodedData.main.temp_max
                        tempMin = decodedData.main.temp_min
                        mainWeather = decodedData.weather[0].mainWeather
                        lon = decodedData.coord.lon
                        lat = decodedData.coord.lat
                    } catch {
                        print("Error! Something went wrong.")
                    }
                }
            }
        }.resume()
    }
    
    func updateWeatherForecastData() {
        //convert string url to swift url
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=b4656ed1180f72efa00dbb397a127ef8"
        let url = URL(string: urlString)
        
        print(lat)
        print(lon)
        
        //use to connect to api; either get data, response or error
        //use _ if u do not need it
        URLSession.shared.dataTask(with: url!) {data, _, error in
            //telling the machine this is an async operation so might have to wait
            DispatchQueue.main.async {
                //if we get an actual data
                if let data = data {
                    do {
                        let count = 0...5
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(ForecastData.self, from: data)
                        for i in count {
                            tempMaxForecast[i] = decodedData.daily[i].temp.max
                            tempMinForecast[i] = decodedData.daily[i].temp.min
                            //mainWeather = decodedData.weather[0].mainWeather
                        }
                    } catch {
                        print("Error! Something went wrong.")
                    }
                }
            }
        }.resume()
    }
    
}

struct DetailedCityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedCityView(city: "Singapore", temperature: 16.7, icon: "01d", bgColor: "night", fontColor: Color.white, time: Date())
    }
}
