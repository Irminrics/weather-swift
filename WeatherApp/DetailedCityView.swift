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
                            Text("Thunder | H:-1 L:-6 | feels like -9")
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
                        HStack (spacing: 18.5) {
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                            VStack {
                                
                            }
                            .frame(width: 60, height: 110, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width-50, alignment: .center)
                    
                }
                
                
                
                
                HStack {
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width-50,height: UIScreen.main.bounds.height-700, alignment: .center)
                .background(Color.white)
                .cornerRadius(10)
                
                
            }
            
            
        }
        .background(Color("lightgray"))
        .ignoresSafeArea()
        
    }
}

struct DetailedCityView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedCityView(city: "Singapore", temperature: 16.7, icon: "01d", bgColor: "night", fontColor: Color.white)
    }
}
