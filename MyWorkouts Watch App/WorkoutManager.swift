//
//  WorkoutManager.swift
//  MyWorkouts Watch App
//
//  Created by Radif Sharafullin on 1/3/26.
//

import Foundation
import HealthKit
import Combine

class WorkoutManager : NSObject, ObservableObject{
    @Published var selectedWorkout: HKWorkoutActivityType?{
        didSet{
            guard let selectedWorkout = selectedWorkout else { return }
            startWorkout(workoutType: selectedWorkout)
        }
    }
    
    @Published var showingSummaryView : Bool = false{
        didSet{
            if showingSummaryView == false{
                resetWorkout()
            }
        }
    }
    
    @Published var session: HKWorkoutSession?
    @Published var builder: HKLiveWorkoutBuilder?
    
    let healthStore = HKHealthStore()
    
    func startWorkout(workoutType: HKWorkoutActivityType){
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        do{
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
            
            // Enable data collection from the workout session
            builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                          workoutConfiguration: configuration)
            
        }catch{
            return
        }
        
        //start workout session, begin data collection
        let startDate = Date()
        session?.delegate = self
        builder?.delegate = self
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            
        }
    }
    
    func requestAuthorization(){
        let typesToShare : Set = [
            HKQuantityType.workoutType()
        ]
        
        let typesToRead : Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.activitySummaryType()
        ]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead){ (success, error) in
            
        }
    }
    
    // MARK: State Control
    
    @Published var running = false
    func pause(){
        session?.pause()
    }
    func resume(){
        session?.resume()
    }
    
    func togglePause(){
        if running == true{
            pause()
        }else{
            resume()
        }
    }
    
    func endWorkout(){
        session?.end()
        showingSummaryView = true
    }
    
    func resetWorkout(){
        selectedWorkout = nil
        builder = nil
        session = nil
        activeEnergy = 0
        heartRate = 0
        averageHeartRate = 0
        running = false
    }
    
    // MARK: metrics
    @Published var averageHeartRate : Double = 0
    @Published var heartRate : Double = 0
    @Published var activeEnergy : Double = 0
    @Published var metrics : Double = 0
    
    func updateForStatistics(_ statistics : HKStatistics?){
        guard let statistics = statistics else {return}
        DispatchQueue.main.async{
            switch statistics.quantityType{
                case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                    
                case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let activeEnergyUnit = HKUnit.kilocalorie()
                self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: activeEnergyUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning):
                let distanceUnit = HKUnit.meter()
                self.metrics = statistics.sumQuantity()?.doubleValue(for: distanceUnit) ?? 0
            default:
                break
            }
        }
    }
}

extension WorkoutManager : HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date){
        DispatchQueue.main.async {
            self.running = toState == .running
        }
        
        //wait to transition state
        
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                
            }
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: any Error){
        
    }
}

extension WorkoutManager : HKLiveWorkoutBuilderDelegate {
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>){
        for type in collectedTypes{
            guard let quantityType = type as? HKQuantityType else { return }
            let statistics = workoutBuilder.statistics(for: quantityType)
            
            updateForStatistics(statistics)
        }
    }

    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder){
        
    }
}
