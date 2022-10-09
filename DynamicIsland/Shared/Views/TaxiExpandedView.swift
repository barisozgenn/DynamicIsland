//
//  TaxiExpandedView.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import SwiftUI

struct TaxiExpandedView: View {
    @State var taxi: Taxi
    @State var percent: Double
    @State var minute: Int
    @State var subTitle: String
    
    var body: some View {
        VStack(spacing:0){
            
            GeometryReader { (geometry) in
                ZStack(alignment: .leading){
                    
                    // background part
                    Spacer()
                        .frame(width: .infinity, height: 4)
                        .background(.gray)
                    if taxi == .arrived {
                        VStack {
                            Image(systemName: "mappin.and.ellipse")
                                .padding(2)
                                .frame(width: 24, height: 24)
                                .background(.gray)
                                .cornerRadius(4)
                            Spacer()
                                .frame(width: 4, height: 10)
                                .background(.gray)
                            Spacer()
                                .frame(width: 17, height: 3.9)
                                .background(.gray)
                                .offset(x: -6 , y: 0)
                        }
                        .offset(x: geometry.size.width - 29 , y: -16.7)
                        
                    }
                    HStack{
                        // filled part
                        Spacer()
                            .frame(width: sliderFilledWidth(maxWidth: geometry.size.width), height: 4)
                            .background(.purple)
                        
                        // slider image
                        VStack {
                            Image(systemName: taxi.imageName)
                                .padding(2)
                                .frame(width: 24, height: 24)
                                .background(.purple)
                                .cornerRadius(4)
                            Spacer()
                                .frame(width: 4, height: 10)
                                .background(.purple)
                            Spacer()
                                .frame(width: 17, height: 3.9)
                                .background(.purple)
                                .offset(x: -6 , y: 0)
                        }
                        .offset(x:0 , y: -16.7)
                    }
                    
                    
                    
                }
            }
            .frame(height: 30)
            
            
            
            HStack{
                // title & description
                VStack(alignment: .leading){
                    
                    Text(taxi.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                    
                    Text(subTitle)
                        .font(.subheadline)
                    
                }
                
                Spacer()
                
                HStack(spacing: 3){
                    Image(systemName: "clock")
                    
                    Text("\(minute)m")
                }
                .padding(.horizontal, 6)
                .padding(.vertical,10)
                .background(.purple)
                .cornerRadius(4)
                
            }
        }
        .frame(width: .infinity, height: .infinity)
        .fontWeight(.semibold)
        .padding(.horizontal)
    }
    
    func sliderFilledWidth(maxWidth: Double) -> Double {
    
        if taxi != .arrived {
            return maxWidth / 100 * percent
        }
        else { return maxWidth / 100 * 2 }
    }
}

struct TaxiExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        
        let taxi = Taxi.arrived

        TaxiExpandedView(
            taxi: taxi,
            percent: 70,
            minute: 3,
            subTitle :"Pickup by BO Tower on JBR St")
        .preferredColorScheme(.dark)
    }
}
