//
//  DynamicIslandView.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import SwiftUI

struct DynamicIslandView: View {
    var body: some View {
        
        ZStack{
            LinearGradient(
                colors: [
                    .purple,
                    .cyan
                ],
                startPoint: .top,
                endPoint: .bottom)
            .ignoresSafeArea()
            
            Text("Dynamic Island")
                .font(.title)
                .foregroundColor(.white)
                .shadow(radius: 7)
        }
        
        
    }
}

struct DynamicIslandView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicIslandView()
    }
}
