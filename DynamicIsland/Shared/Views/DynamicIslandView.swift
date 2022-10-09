//
//  DynamicIslandView.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import SwiftUI

struct DynamicIslandView: View {
    @EnvironmentObject private var vm : DynamicIslandViewModel
    
    var body: some View {
       
        ZStack{
            LinearGradient(
                colors: [
                    .purple,
                    .cyan
                ],
                startPoint: .bottom,
                endPoint: .top)
            .ignoresSafeArea()
            
            VStack{
                Image("ioslogobar-16x1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 77)

                Text("Dynamic Island")
                    .font(.title)
                    .foregroundColor(.white)
                    .shadow(radius: 7)
            }
            
            .onAppear{
                vm.setActiviy()
            }
        }
        
    }
}

struct DynamicIslandView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicIslandView()
            .environmentObject(DynamicIslandViewModel())
    }
}
