//
//  MonsterGameVIew.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 24/05/23.
//

import SwiftUI

struct MonsterGameVIew: View {
    @ObservedObject var workoutSession: WorkoutSession
    @ObservedObject var sounController = SoundController()
    @Binding var percentHealth: Int
    @Binding var goToSummary: Bool
    @State var heartRateLow: Bool = false
    @State var heartRateHigh: Bool = false
    @State var NotReducedBefore: Bool = true
    var maxHeartRate: Int = 0
    var body: some View {
        if workoutSession.status == .inProgress {
            VStack(spacing: 10) {
                Spacer()
                
                if heartRateLow {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("heart rate too low")
                    }
                } else if heartRateHigh {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("heart rate too high")
                    }
                    
                }

                Image("monster").resizable().frame(width: 110, height: 130)
                HStack {
                    Text("\(percentHealth)")
                    ProgressView(value: Double(percentHealth), total: 200).progressViewStyle(DefaultProgressViewStyle()).tint(Color("mainButton")).frame(width: 130)
                        .onChange(of: workoutSession.heartbeatFormatter()) { newValue in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            if workoutSession.status == .inProgress {
                                let beatRate = Int(workoutSession.heartbeatFormatter())
                                if beatRate != 0 {
                                    if (beatRate!) > 80 && (beatRate!) < maxHeartRate {
                                        let temp = Int(Double(beatRate! - 80) / Double(maxHeartRate) * 100)
                                        heartRateLow = false
                                        heartRateHigh = false
                                        if percentHealth - temp > 0 {
                                            withAnimation(.spring()) {
                                                percentHealth -= temp
                                                if NotReducedBefore {
                                                    NotReducedBefore = false
                                                }
                                            }

                                        } else {
                                            workoutSession.endWorkoutSession()
                                            goToSummary = true
                                        }
                                        print("percent: \(percentHealth)")
                                    } else {
                                        print("masuk")
                                        if beatRate! < 80 {
                                            heartRateLow = true
                                            heartRateHigh = false
                                        } else {
                                            heartRateLow = false
                                            heartRateHigh = true
                                        }
                                        if !NotReducedBefore && percentHealth == 200 {
                                            workoutSession.endWorkoutSession()
                                            goToSummary = true
                                        } else if !NotReducedBefore && percentHealth < 200 {
                                            withAnimation(.spring()) {
                                                percentHealth += 5
                                            }
                                        }
                                        

                                    }
                                }
                            }
                        }

                    }
                }
            }
        } else if workoutSession.status == .paused {
            VStack(spacing: 10) {
                Spacer()
                
                if heartRateLow {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("heart rate too low")
                    }
                } else if heartRateHigh {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                        Text("heart rate too high")
                    }
                    
                }

                Image("monster").resizable().frame(width: 110, height: 130)
                HStack {
                    Text("\(percentHealth)")
                    ProgressView(value: Double(percentHealth), total: 200).progressViewStyle(DefaultProgressViewStyle()).tint(Color("mainButton")).frame(width: 130)
                }
            }
        }
    }
}

//struct MonsterGameVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        MonsterGameVIew()
//    }
//}
