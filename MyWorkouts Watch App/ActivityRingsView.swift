//
//  ActivityRingsView.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import Foundation
import SwiftUI
import HealthKit


struct ActivityRingsView: WKInterfaceObjectRepresentable {
    
    
    let healthStore : HKHealthStore
    
    func makeWKInterfaceObject(context: Context) -> some WKInterfaceObject {
        
        let activityRingObject = WKInterfaceActivityRing()
        
        let calendar = Calendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day], from: Date())
        components.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: components)
        
        let query = HKActivitySummaryQuery(predicate: predicate){ query, summaries, error in
            DispatchQueue.main.async{
                activityRingObject.setActivitySummary(summaries?.first, animated: true)
            }
        }
        healthStore.execute(query)
        
        return activityRingObject
    }
    
    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceObjectType, context: Context) {
        
    }
}

#Preview {
    //ActivityRingsView(HKHealthStore())
}
