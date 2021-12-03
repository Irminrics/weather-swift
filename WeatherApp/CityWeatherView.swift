//
//  CityWeatherView.swift
//  CityWeatherView
//
//  Created by Jun Kang on 11/8/21.
//
import SwiftUI

struct CityWeatherView: View {
    var city: String
    var date: Date
    var temperature: Double
    var color: String
    var textColor: Color
    var icon: String
    var body: some View {
        NavigationLink (
            destination: DetailedCityView(city: city, temperature: temperature, icon: icon, bgColor: color, fontColor: textColor, time: date),
            label: {
                HStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack{Spacer()}
                            Text("\(city)")
                                .foregroundColor(textColor)
                                .font(Font.custom("Montserrat-Regular", size: 35))
                            
                            Text("\(date.toTimeFormat())")
                                .foregroundColor(textColor)
                                .font(Font.custom("Montserrat-Regular", size: 20))
                            
                            Spacer()
                        }
                        .padding(.leading, 16)
                        
                        VStack{
                            Text("\(Int(round(temperature)))°")
                                .foregroundColor(textColor)
                                .font(.system(size: 70, weight: .bold))
                        }
                        .padding(.trailing, 13)
                        
                    }
                    .frame(width: 375, height: 120, alignment: .center)
                    .background(Color("\(color)"))
                    .cornerRadius(15)
                    
                    Spacer()
                    
                }
                
            })
            .listRowBackground(Color("lightgray"))
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(city: "Singapore", date: Date(), temperature: 36.0, color: "night", textColor: Color.white, icon: "01d")
    }
}
