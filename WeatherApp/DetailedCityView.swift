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
                                        
                                        
                                        Text("-6º")
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
                                        Text("08")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("-6º")
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
                                        Text("09")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("-6º")
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
                                        Text("10")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("-6º")
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
                                        Text("11")
                                            .font(Font.custom("Montserrat-Regular", size: 18))
                                            .padding(.top, 10)
                                        
                                        Spacer()
                                        
                                        
                                        Text("-6º")
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
                    Spacer()
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
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Spacer()
                                VStack {
                                    Text("Humidity")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                Spacer()
                                VStack {
                                    Text("Wind")
                                        .font(Font.custom("Montserrat-Regular", size: 18))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            .padding(.leading, 25)
                            .padding(.trailing, 30)
                            
                            
                            
                        }
                        
                        
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width-50, height: UIScreen.main.bounds.height-500)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 10)
                .padding(.bottom, 30)
                
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
