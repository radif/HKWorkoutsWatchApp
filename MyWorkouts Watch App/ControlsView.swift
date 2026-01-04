//
//  ControlsView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManager : WorkoutManager
    var body: some View {
        HStack{
            VStack{
                Button{
                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(.red)
                .font(.title2)
                Text("End")
            }
            VStack{
                Button{
                    workoutManager.togglePause()
                }
                    label: {
                        Image(systemName: workoutManager.running ? "pause" : "play")
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
