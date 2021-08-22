//
//  CityWeatherView.swift
//  CityWeatherView
//
//  Created by Jun Kang on 11/8/21.
//
import SwiftUI

struct CityWeatherView: View {
    var city: String
    var time: String
    var temperature: Double
    var color: String
    var textColor: Color
    
    var body: some View {
//        NavigationLink (
//            destination: CityView(),
//            label: {
                HStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack{Spacer()}
                            Text("\(city)")
                                .foregroundColor(textColor)
                                .font(Font.custom("Montserrat-Regular", size: 35))
                            
                            Text("\(time)")
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
                .listRowBackground(Color("lightgray"))
//            })
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(city: "Singapore", time: "", temperature: 36.0, color: "midnight1", textColor: Color.white)
    }
}
