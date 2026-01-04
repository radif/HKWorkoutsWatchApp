//
//  ContentView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI
import HealthKit

struct StartView: View {
    @EnvironmentObject var workoutManager : WorkoutManager
    var workoutTypes : [HKWorkoutActivityType] = [.cycling, .running, .walking]
    
    var body: some View {
        VStack {
            List(workoutTypes){ workoutType in
                NavigationLink(
                    workoutType.name,
                    destination: SessionPagingView(),
                    tag: workoutType,
                    selection: $workoutManager.selectedWorkout
                ).padding(
                    EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
                )
            }.listStyle(.carousel)
            .navigationTitle(Text("Workouts"))
            .onAppear{
                workoutManager.requestAuthorization()
            }
        }
        .padding()
    }
}

extension HKWorkoutActivityType : @retroactive Identifiable{
    public var id : UInt{
        rawValue
    }
    var name : String{
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
            default:
            return ""
        }
    }
}

#Preview {
    NavigationView(content: {
        StartView()
    })
}
