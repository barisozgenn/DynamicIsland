//
//  DeliveryExpandedView.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import SwiftUI

struct DeliveryExpandedView: View {
    
    @State var delivery: Delivery
    @State var percent: Double
    @State var minute: Int
    @State var subTitle: String
    var body: some View {
        VStack(spacing:0){
            
            GeometryReader { (geometry) in
                ZStack(alignment: .leading){
                    
                    // background part
                    HStack(spacing: 1){
                        Spacer()
                            .frame(width: geometry.size.width * 0.15, height: 4)
                            .background(delivery == .delivered ? .green : .orange)
                            .cornerRadius(4)
                        
                        Spacer()
                            .frame(width: geometry.size.width * 0.60, height: 4)
                            .background(delivery == .delivered ? .green : .blue)
                            .cornerRadius(4)
                        
                        Spacer()
                            .frame(width: .infinity, height: 4)
                            .background(delivery == .delivered ? .green : .brown)
                            .cornerRadius(4)
                        
                        Spacer()
                            .frame(width: .infinity, height: 4)
                            .background(.green)
                            .cornerRadius(4)
                    }
                    
                    // filled part
                    HStack{
                        // filled part
                        Spacer()
                            .frame(width: sliderFilledWidth(maxWidth: geometry.size.width), height: 4)
                            .background(.purple.opacity(0))
                        
                        // slider image
                        VStack {
                            ZStack{
                                
                                if delivery != .delivered {
                                    
                                    HStack(spacing: 3){
                                        Image(systemName: "clock")
                                        
                                        Text("\(minute)m")
                                    }
                                    .font(.subheadline)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical,3)
                                    .background(stateColor)
                                    .cornerRadius(4)
                                    .offset(x: percent < 71 ? 42 : -42, y:0)
                                }
                                
                                
                                Image(systemName: delivery.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(4)
                                    .frame(height: 24)
                                
                                    .background(stateColor)
                                    .cornerRadius(4)
                            }
                            
                            
                            Spacer()
                                .frame(width: 4, height: 10)
                                .background(stateColor)
                            Spacer()
                                .frame(width: 14, height: 3.9)
                                .background(stateColor)
                                .cornerRadius(4)
                                .offset(x: 0 , y: 0)
                        }
                        .offset(x:0 , y: -17)
                    }
                    
                }
            }
            .frame(height: 30)
            
            HStack{
                // title & description
                VStack(alignment: .leading){
                    
                    Text(delivery.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(stateColor)
                    
                }
                
                Spacer()
                
                VStack(alignment: .trailing){
                    
                    Text(subTitle)
                        .font(.subheadline)
                    
                }
                
            }
            
        }
        .frame(width: .infinity, height: .infinity)
        .fontWeight(.semibold)
        .padding(.horizontal)
    }
    
    func sliderFilledWidth(maxWidth: Double) -> Double {
        
        if delivery != .delivered {
            return maxWidth / 100 * percent
        }
        else { return maxWidth / 100 * 92 }
    }
    
    var stateColor: Color {
        switch delivery {
        case .preparing: return .orange
        case .onTheWay: return .blue
        case .arrivingSoon: return .brown
        case .delivered: return . green
        }
    }
}

struct DeliveryExpandedView_Previews: PreviewProvider {
    static var previews: some View {
        
        let delivery = Delivery.delivered
        
        DeliveryExpandedView(
            delivery: delivery,
            percent: 92,
            minute: 7,
            subTitle :"Pickup by BO Tower on JBR St")
        .preferredColorScheme(.dark)
    }
}
