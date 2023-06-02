//
//  MonsterGameVIew.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 24/05/23.
//

import SwiftUI

struct MonsterGameVIew: View {
    @ObservedObject var workoutSession: WorkoutSession
    @ObservedObject var sounController: SoundController
    @Binding var percentHealth: Int
    @Binding var goToSummary: Bool
    @State var heartRateLow: Bool = false
    @State var heartRateHigh: Bool = false
    @State var NotReducedBefore: Bool = true
    var maxHeartRate: Int = 0
    var body: some View {
        VStack(spacing: 10) {
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
            Image("monster").resizable().frame(width: 100, height: 120)
            HStack {
                Text("\(percentHealth)")
                ProgressView(value: Double(percentHealth), total: 15000).progressViewStyle(DefaultProgressViewStyle()).tint(Color("mainButton")).frame(width: 130)
                    .onChange(of: workoutSession.heartbeatFormatter()) { newValue in
                        if workoutSession.status == .inProgress {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                let beatRate = Int(workoutSession.heartbeatFormatter())
                                if beatRate != 0 {
                                    if (beatRate!) > 80 && (beatRate!) < maxHeartRate {
                                        let temp = Int(Double(beatRate! - 80) / Double(maxHeartRate) * 100)
                                        heartRateLow = false
                                        heartRateHigh = false
                                        if percentHealth - temp > 0 {
                                            sounController.hitMonster()
                                            withAnimation(.spring()) {
                                                percentHealth -= temp
                                                
                                                if NotReducedBefore {
                                                    NotReducedBefore = false
                                                }
                                            }
                                            
                                        } else {
                                            sounController.win()
                                            workoutSession.endWorkoutSession()
                                            goToSummary = true
                                        }
                                        print("percent: \(percentHealth)")
                                    } else {
                                        print("masuk")
                                        if beatRate! <= 80 {
                                            heartRateLow = true
                                            heartRateHigh = false
                                        } else if beatRate! >= maxHeartRate {
                                            heartRateLow = false
                                            heartRateHigh = true
                                        }
                                        if !NotReducedBefore {
                                            sounController.heal()
                                            withAnimation(.spring()) {
                                                percentHealth += 5
                                                
                                            }
                                            if percentHealth >= 15000 {
                                                sounController.gameOver()
                                                workoutSession.endWorkoutSession()
                                                goToSummary = true
                                            }
                                        }
                                        
                                        
                                    }
                                }
                            }
                        }
                        
                        
                    }
            }
//            HStack{
//                Circle()
//                    .frame(width: 8, height: 8)
//                    .foregroundColor(Color.gray)
//                Circle()
//                    .frame(width: 8, height: 8)
//                    .foregroundColor(Color.white)
//            }
        }
    }
}

//struct MonsterGameVIew_Previews: PreviewProvider {
//    static var previews: some View {
//        MonsterGameVIew()
//    }
//}
