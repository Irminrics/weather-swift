//
//  DetailedCityView.swift
//  DetailedCityView
//
//  Created by Jun Kang on 26/8/21.
//

import SwiftUI

struct DetailedCityView: View {
    var bgColor: String
    var fontColor: Color
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack {
                        NavigationLink (
                            destination: CityView(),
                            label: {
                                Button(action: {}, label: {
                                    Image(systemName: "chevron.backward")
                                        .padding(.top, 5)
                                        .padding(.leading, 9)
                                        .padding(.trailing, 9)
                                        .padding(.bottom, 5)
                                })
                                    .foregroundColor(Color.red)
                                    .background(Color.white)
                                    .font(.system(size: 18))
                                    .cornerRadius(12)
                                    .padding(.leading, 30)
                                
                            })

                        Spacer()
                        
                        Text(Date().toDayFormat())
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
                Spacer()
            }
            .padding(.top, 70)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color("\(bgColor)"))
            .ignoresSafeArea()
            
        }
        
    }
}
