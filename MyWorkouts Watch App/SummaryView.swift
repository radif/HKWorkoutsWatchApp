//
//  SummaryView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var durationFormatter :
    DateComponentsFormatter = {
       let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    var body: some View {
        if workoutManager.session == nil {
            ProgressView("Saving Workout")
                .navigationBarHidden(true)
        }else{
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    SummaryMetricView(
                        title: "Total Time",
                        value: durationFormatter.string(from: 30 * 60 + 15) ?? "")
                    .accentColor(.yellow)
                    SummaryMetricView(
                        title: "Total Distance",
                        value: Measurement(
                            value: 1625.0,
                            unit: UnitLength.meters)
                        .formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .road
                            )
                        )
                    ).accentColor(.green)
                    SummaryMetricView(
                        title: "Total Energy",
                        value: Measurement(
                            value: 96,
                            unit: UnitEnergy.kilocalories
                        ).formatted(
                            .measurement(
                                width: .abbreviated,
                                usage: .workout
                            )
                        )
                        
                    ).accentColor(.pink)
                    SummaryMetricView(
                        title: "Avg. Heart Rate",
                        value: 143
                            .formatted(.number.precision(.fractionLength(0))) + "bpm"
                    ).accentColor(.red)
                    Text("Activity Rings")
                    ActivityRingsView(
                        healthStore: HKHealthStore()
                    ).frame(width:50, height: 50)
                    
                    Button("Done"){
                        dismiss()
                    }
                }.scenePadding()
            }
            .navigationBarTitle("Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SummaryView()
}


struct SummaryMetricView : View {
    var title : String
    var value : String
    var body: some View {
        Text(title)
        Text(value)
            .font(.system(.title2, design: .rounded)
                .lowercaseSmallCaps())
            .foregroundColor(.accentColor)
        Divider()
    }
}
