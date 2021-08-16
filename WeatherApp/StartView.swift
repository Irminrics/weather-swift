//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jun Kang on 4/8/21.
//

import SwiftUI

struct StartView: View {
    @AppStorage("started") private var started = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    Image("weather-icon")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .padding(.top, 70)
                    
                    Spacer()
                    
                    Text("Just another weather app")
                        .frame(width: 300, height: 200)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color("darkblue"))
                        .multilineTextAlignment(.center)
                    
                    Text("Powered by OpenWeather API")
                        .frame(width: 250, height:70, alignment: .center)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink (
                        destination: CityView().onAppear{started=true},
                        label: {
                            Text("Get Started")
                                .frame(width: 250, height: 50)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(Color("darkblue"))
                                .background(Color.yellow)
                                .cornerRadius(12)
                                .padding(.bottom, 100)
                        })
                }
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
