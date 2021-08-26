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
        NavigationLink (
            destination: DetailedCityView(bgColor: color, fontColor: Color.white),
            label: {
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
                                    .font(Font.custom("Montserrat-Regular", size: 35))
                                    .foregroundColor(textColor)
                                
                                Text("My current location")
                                    .foregroundColor(textColor)
                                    .font(Font.custom("Montserrat-Regular", size: 18))
                            }
                            .padding(.trailing, 5)
                            .padding(.bottom, 28)
                        }
                        
                        VStack{
                            Spacer()
                            Text("\(Int(round(temperature)))°")
                                .frame(width: 150, alignment: .trailing)
                                .foregroundColor(textColor)
                                .font(.system(size: 70, weight: .bold))
                                .padding(.bottom, 15)
                                .padding(.trailing, -5)
                        }
                    }
                    .frame(width: 375, height: 250)
                    .font(.system(size: 20, weight: .bold))
                    .background(Color("\(color)"))
                    .cornerRadius(15)
                    
                    Spacer()
                }
                
            })
            .listRowBackground(Color("lightgray"))
        
    }
}

struct MainCityWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainCityWeatherView(city: "Singapore", temperature: 39.0, icon: "01d", color: "night", textColor: Color.white)
    }
}
