//
//  WorkOutSession.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 18/05/23.
//

import Foundation
import HealthKit
import SwiftUI

enum WorkoutSessionStatus {
    case inProgress, complete, cancelled, notStarted, paused
}

class WorkoutSession: NSObject, HKLiveWorkoutBuilderDelegate, HKWorkoutSessionDelegate, ObservableObject {
    @Published var distanceStatistics: HKStatistics?
    @Published var energyBurnedStatistics: HKStatistics?
    @Published var heartRateStatistics: HKStatistics?
    @Published var elapsedTimeStatistics: HKStatistics?
    
    @Published var distance: Double?
    @Published var energyBurned: Double?
    @Published var elapsedTime: TimeInterval?
    @Published var bpm: Double?
    @Published var averageBPM: Double?
    @Published var status = WorkoutSessionStatus.notStarted
    @Published var workoutData: HKWorkout?
    
    @Published var session: HKWorkoutSession?
    @Published var builder: HKLiveWorkoutBuilder?
    @Published var startTimer = false
    
    var healthStore = HKHealthStore()
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        DispatchQueue.main.async {
            self.distance = workoutBuilder.statistics(for: .init(.distanceWalkingRunning))?.sumQuantity()?.doubleValue(for: .meterUnit(with: .kilo))
            self.distanceStatistics = workoutBuilder.statistics(for: .init(.distanceWalkingRunning))
            self.heartRateStatistics = workoutBuilder.statistics(for: .init(.heartRate))
            self.energyBurned = workoutBuilder.statistics(for: .init(.activeEnergyBurned))?.sumQuantity()?.doubleValue(for: .kilocalorie())
            self.energyBurnedStatistics = workoutBuilder.statistics(for: .init(.activeEnergyBurned))
            self.elapsedTime = workoutBuilder.elapsedTime
            self.bpm = self.calculateBPM()
            self.averageBPM = self.calcAvgBPM()
        }
        
    }
    
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func setupSession() {
        let typesToShare: Set = [HKQuantityType.workoutType()]
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        ]
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            
        }
    }
    
    func startWorkoutSession() {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session!.associatedWorkoutBuilder()
            builder!.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
            session!.delegate = self
            builder!.delegate = self
            session?.startActivity(with: Date())
            builder!.beginCollection(withStart: Date()) { success, error in
                if !success {
                    print("Unable to start collection, the error: \(error)")
                }
                self.status = .inProgress
            }
        } catch {
            print("Unable to create workout session, the error: \(error)")
        }
    }
    
    func endWorkoutSession() {
        guard let session = session else {
            print("Sesssion is nil. Unable to end workout.")
            return
        }
        
        guard let builder = builder else {
            print("Builder is nil. Unable to end workout")
            return
        }
        
        session.end()
        
        builder.endCollection(withEnd: Date()) { success, error in
            if !success {
                print("Unable to end collection.")
                return
            }
            
            builder.finishWorkout { workout, error in
                if workout == nil {
                    print("Unable to rad workout")
                    return
                }
                DispatchQueue.main.async {
                    self.status = .complete
                    self.workoutData = workout
                }
                
            }
        }
    }
    
    func resumeWorkout() {
        guard let session = session else {
            print("Session is nil. Unable to resume workout.")
            return
        }
        session.resume()
        self.status = .inProgress
    }
    
    func pauseWorkout() {
        guard let session = session else {
            print("Session is nil. Unable to pause workout.")
            return
        }
        
        session.pause()
        self.status = .paused
    }
    
    func kcalFormatter()  -> String {
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 3
        return formatter.string(from: (round(10 * self.energyBurned!) / 10) as NSNumber)!
    }
    
    func timerFormatter(countTimer: Int) -> String {
        
        let time = secondsToHoursMinutesSeconds(seconds: countTimer)
        return makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func distanceFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 2
        return formatter.string(from: (round(10 * (self.distance ?? 0)) / 10)  as NSNumber)!
    }
    
    func heartbeatFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 3
        return formatter.string(from: (self.bpm ?? 0) as NSNumber)!
    }
    
    func avgHeartBeatFormatter() -> String {
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 3
        return formatter.string(from: (self.averageBPM ?? 0) as NSNumber)!
    }
    
    func calcScore() {
        
        
    }
}

extension WorkoutSession {
    private func calculateBPM() -> Double? {
        let beatsPerMinute = HKUnit(from: "count/min")
        return self.heartRateStatistics?.mostRecentQuantity()?.doubleValue(for: beatsPerMinute)
    }
    
    private func calcAvgBPM() -> Double? {
        let beatsPerMinute = HKUnit(from: "count/min")
        return self.heartRateStatistics?.averageQuantity()?.doubleValue(for: beatsPerMinute)
    }
}
