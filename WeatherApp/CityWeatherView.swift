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
        NavigationLink (
            destination: CityView(),
            label: {
                HStack {
                    Spacer()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack{Spacer()}
                            Text("\(city)")
                                .foregroundColor(textColor)
                                .font(.system(size: 35))
                            
                            Text("\(time)")
                                .foregroundColor(textColor)
                            
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        VStack{
                            Text("\(Int(round(temperature)))°")
                                .foregroundColor(textColor)
                                .font(.system(size: 70, weight: .bold))
                        }
                        .padding(.trailing, 15)
                        
                    }
                    .frame(width: 375, height: 120, alignment: .center)
                    .background(Color("\(color)"))
                    .cornerRadius(15)
                    
                    Spacer()
                    
                }
            })
    }
}

struct CityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherView(city: "Singapore", time: "", temperature: 36.0, color: "midnight1", textColor: Color.white)
    }
}
