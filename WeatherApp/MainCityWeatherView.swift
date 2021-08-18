//
//  MainCityWeatherView.swift
//  MainCityWeatherView
//
//  Created by Jun Kang on 11/8/21.
//
import SwiftUI

struct MainCityWeatherView: View {
    var city: String
    var temperature: Double
    var icon: String
    var color: String
    var textColor: Color
    var body: some View {
//        NavigationLink (
//            destination: CityView(),
//            label: {
                HStack {
                    
                    Spacer()
                    
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
                            .padding(.leading, 12)
                        }
                        
                        VStack{
                            Spacer()
                            Text("\(Int(round(temperature)))°")
                                .frame(width: 150, alignment: .trailing)
                                .foregroundColor(textColor)
                                .font(.system(size: 70, weight: .bold))
                                .padding(.leading, 5)
                                .padding(.bottom, 15)
                        }
                    }
                    .frame(width: 375, height: 250)
                    .font(.system(size: 20, weight: .bold))
                    .background(Color("\(color)"))
                    .cornerRadius(15)
                    
                    Spacer()
                }
//            })
    }
}

struct MainCityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainCityWeatherView(city: "Singapore", temperature: 39.0, icon: "01d", color: "midnight1", textColor: Color.white)
    }
}
