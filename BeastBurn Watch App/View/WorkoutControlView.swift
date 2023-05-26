//
//  workoutControlView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 23/05/23.
//

import SwiftUI

struct WorkoutControlView: View {
    @ObservedObject var workoutSession: WorkoutSession
    var body: some View {
        VStack {
            if workoutSession.status == .inProgress {
                Button {
                    workoutSession.pauseWorkout()
                } label: {
                    Text("Pause").frame(maxWidth: 150, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("workoutControlPauseResume")).foregroundColor(Color("workoutControlFont")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }.buttonStyle(PlainButtonStyle())
            } else if workoutSession.status == .paused {
                Button {
                    workoutSession.resumeWorkout()
                } label: {
                    Text("Resume").frame(maxWidth: 150, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("workoutControlPauseResume")).foregroundColor(Color("workoutControlFont")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }.buttonStyle(PlainButtonStyle())
            }
            
            NavigationLink(destination: MainPageView(), label: {
                Text("Home").frame(maxWidth: 150, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("workoutControlHome")).foregroundColor(Color("workoutControlFont")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }).buttonStyle(PlainButtonStyle())
            
            Button {
                workoutSession.endWorkoutSession()
            } label: {
                Text("Water Lock").frame(maxWidth: 150, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("workoutControlWaterLock")).foregroundColor(Color("workoutControlFont")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }.buttonStyle(PlainButtonStyle())
        }
    }
}

//struct WorkoutControlView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutControlView().environmentObject(WorkoutSession())
//    }
//}
