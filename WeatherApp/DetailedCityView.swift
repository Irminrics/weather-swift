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
                
                //icon
                HStack{
                    Spacer()
                    Image("01d")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200, alignment: .leading)
                        .padding()
                    Spacer()
                }

                
                VStack {
                    
                    HStack{
                        Text("\(Int(round(-36.6)))°")
                        //.foregroundColor("textColor")
                            .font(.system(size: 90, weight: .bold))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    
                    HStack{
                        Text("Singapore")
                            .font(Font.custom("Montserrat-Regular", size: 40))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    
                    HStack{
                        Text("Thunder | H:-1 L:-6 | feels like -9")
                            .font(Font.custom("Montserrat-Regular", size: 20))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.top, -20)
                .padding(.leading, 20)
                
                Spacer()
                
                ZStack{
                    Spacer()
                }
                .frame(width: 450)
                .background(Color("lightgray"))
                
            }
            .padding(.top, 70)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .background(Color("\(bgColor)"))
            .ignoresSafeArea()
            
            
            
        }
        
    }
}

struct DetailedCityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedCityView(bgColor: "night", fontColor: Color.white)
    }
}
