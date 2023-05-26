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
    @State var goToSummary: Bool = false
    @State var percentHealth: Int = 200
    @State var countTimer: Int = 0
    @Binding var ageInput: Int
    
    @State var startRunView: Bool = false
    var maxHeartRate: Int = 0
    var body: some View {
        VStack {
            TabView(selection: $currentView) {
                WorkoutView(workoutSession: workOutSession, countTimer: $countTimer).tag(0)
                MonsterGameVIew(workoutSession: workOutSession, percentHealth: $percentHealth, goToSummary: $goToSummary, maxHeartRate: maxHeartRate).tag(1)
                
            }.onAppear {
                if workOutSession.status == .notStarted {
                    workOutSession.startWorkoutSession()
                }
            }.tabViewStyle(PageTabViewStyle())
            
        }.fullScreenCover(isPresented: $goToSummary) {
            SummaryView(workoutSession: workOutSession, countTimer: $countTimer, maxHeartRate: maxHeartRate, percentHealth: percentHealth, ageInput: $ageInput)
        }
        
    }
}

struct CoreFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        CoreFeaturesView(ageInput: .constant(0))
    }
}
