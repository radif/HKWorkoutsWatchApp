//
//  ControlsView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI

struct ControlsView: View {
    var body: some View {
        HStack{
            VStack{
                Button{
                    
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
                Text("End")
            }
            VStack{
                Button{
                    
                }
                    label: {
                    Image(systemName: "pause")
                }
                .tint(.blue)
                .font(.title2)
                Text("Start")
            }
        }
    }
}

#Preview {
    ControlsView()
}
