//
//  CoreView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 23/05/23.
//

import SwiftUI

struct CoreFeaturesView: View {
    @State var currentView: Int = 0
    @StateObject var workOutSession = WorkoutSession()
    @ObservedObject var soundController: SoundController
    @State var goToSummary: Bool = false
    @State var percentHealth: Int = 15000
    @State var countTimer: Int = 0
    @Binding var ageInput: Int
    
    var maxHeartRate: Int = 0
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                PagerManager(pageCount: 2, currentIndex: $currentView) {
                    WorkoutView(workoutSession: workOutSession, countTimer: $countTimer)
                    MonsterGameVIew(workoutSession: workOutSession, sounController: soundController, percentHealth: $percentHealth, goToSummary: $goToSummary, maxHeartRate: maxHeartRate)
                }
                HStack{
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(currentView==1 ? Color.gray:Color.white)
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(currentView==1 ? Color.white:Color.gray)
                }
                
            }.frame(height: proxy.size.height * 1.18).onAppear {
                if workOutSession.status == .notStarted {
                    workOutSession.startWorkoutSession()
                }
            }.fullScreenCover(isPresented: $goToSummary) {
                SummaryView(workoutSession: workOutSession, countTimer: $countTimer, maxHeartRate: maxHeartRate, percentHealth: percentHealth, ageInput: $ageInput)
            }
        }
                
    }
}

//struct CoreFeaturesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoreFeaturesView(ageInput: .constant(0))
//    }
//}
