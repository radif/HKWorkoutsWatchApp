//
//  SessionPagingView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI
import WatchKit

struct SessionPagingView: View{
    
    enum Tab{
        case controls, metrics, nowPlaying
    }
    @EnvironmentObject var workoutManager : WorkoutManager
    @State private var selection : Tab = .metrics
    
    var body : some View {
        TabView(selection: $selection) {
            ControlsView().tag(Tab.controls)
            MetricsView().tag(Tab.metrics)
            NowPlayingView().tag(Tab.nowPlaying)
        }
        .navigationTitle(workoutManager.selectedWorkout?.name ?? "")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(selection == .nowPlaying)
        .onChange(of: workoutManager.running) { _ in
            displayMetricsView()
        }
    }
    
    func displayMetricsView(){
        withAnimation{
            selection = .metrics
        }        
    }
}
#Preview {
    SessionPagingView()
        .environmentObject(WorkoutManager())
}
