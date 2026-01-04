//
//  MyWorkoutsApp.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI

@main
struct MyWorkouts_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                StartView()
            }).environmentObject(workoutManager)
                .sheet(isPresented: $workoutManager.showingSummaryView){
                    SummaryView()
                        .environmentObject(workoutManager)
                }
        }
    }
}
