//
//  MetricsView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        TimelineView(
            MetricsTimelineSchedule(startDate: workoutManager.builder?.startDate ?? Date()
                                   )
        ){ context in
            VStack(alignment: .leading) {
                ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0, showSubseconds: true)
                    .foregroundColor(.yellow)
                    .fontWeight(.semibold)
                Text(
                    Measurement(
                        value: workoutManager.activeEnergy,
                        unit: UnitEnergy.kilocalories
                    ).formatted(
                        .measurement(
                            width: .abbreviated,
                            usage: .workout
                        )
                    )
                )
                Text(
                    workoutManager.heartRate.formatted(
                        .number.precision(.fractionLength(0))
                    ) + " bpm"
                )
                Text(
                    Measurement(
                        value: workoutManager.metrics,
                        unit: UnitLength.meters
                    ).formatted(
                        .measurement(
                            width: .abbreviated,
                            usage: .road
                        )
                    )
                )
            }
            .font(.system(.title, design: .rounded)
                .monospacedDigit()
                .lowercaseSmallCaps()
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges :.bottom)
            .scenePadding()
        }
    }
}

struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    
    init(startDate: Date) {
        self.startDate = startDate
    }
    
    func entries(from startDate: Date, mode: Mode) -> PeriodicTimelineSchedule.Entries {
        let interval: TimeInterval = (mode == .lowFrequency) ? 1.0 : 1.0 / 30.0
        return PeriodicTimelineSchedule(
            from: self.startDate,
            by: interval
        ).entries(from: startDate, mode: mode)
    }
}

#Preview {
    MetricsView()
}
