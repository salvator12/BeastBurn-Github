//
//  WorkoutView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 19/05/23.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workoutSession: WorkoutSession
    @State private var scale = 1.0
    @Binding var countTimer: Int
    @State var currPage = 0
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading) {
            if workoutSession.status == .inProgress {
                VStack(alignment: .leading, spacing: 3) {
                    Text("\(workoutSession.timerFormatter(countTimer: countTimer))").foregroundColor(Color("mainButton")).font(.system(size: 30))
                        .onReceive(timer) { _ in
                        if workoutSession.status == .inProgress {
                            countTimer += 1
                        }
                    }
                    
                    if workoutSession.bpm != 0 {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20).foregroundColor(.red)
                            HStack {
                                Text(workoutSession.heartbeatFormatter()).font(.system(size: 25)).foregroundColor(Color("softWhite"))
                                Text("BPM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                            }
                            
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20).foregroundColor(.red)
                            HStack {
                                Text("--").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                                Text("BPM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                            }
                        }
                        
                    }
                    
                    if workoutSession.energyBurned != nil {
                        HStack(spacing: 8) {
                            Image(systemName: "flame").resizable().frame(width: 20, height: 25).foregroundColor(Color("flame"))
                            Text("\(workoutSession.kcalFormatter())").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("Kcal").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                            
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: "flame").resizable().frame(width: 20, height: 25).foregroundColor(Color("flame"))
                            Text("--").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("Kcal").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                        }
                        
                    }
                    
                    if workoutSession.distance != nil {
                        HStack(spacing: 8) {
                            Image(systemName: "ruler").resizable().resizable().frame(width: 25, height: 15).foregroundColor(Color("distance"))
                            Text(workoutSession.distanceFormatter()).font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("KM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: "ruler").resizable().frame(width: 25, height: 15).foregroundColor(Color("distance"))
                            Text("--").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("KM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                        }
                    }
                }
                Button {
                    workoutSession.pauseWorkout()
                } label: {
                    Text("PAUSE").frame(maxWidth: 150, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("workoutControlPauseResume")).foregroundColor(Color("workoutControlFont")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }.buttonStyle(PlainButtonStyle())
            } else if workoutSession.status == .paused {
                VStack(alignment: .leading, spacing: 3) {
                    Text("\(workoutSession.timerFormatter(countTimer: countTimer))").foregroundColor(Color("mainButton")).font(.system(size: 30))
                        .onReceive(timer) { _ in
                        if workoutSession.status == .inProgress {
                            countTimer += 1
                        }
                    }
                    
                    if workoutSession.bpm != 0 {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20).foregroundColor(.red)
                            HStack {
                                Text(workoutSession.heartbeatFormatter()).font(.system(size: 25)).foregroundColor(Color("softWhite"))
                                Text("BPM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                            }
                            
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20).foregroundColor(.red)
                            HStack {
                                Text("--").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                                Text("BPM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                            }
                        }
                        
                    }
                    
                    if workoutSession.energyBurned != nil {
                        HStack(spacing: 8) {
                            Image(systemName: "flame").resizable().frame(width: 20, height: 25).foregroundColor(Color("flame"))
                            Text("\(workoutSession.kcalFormatter())").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("Kcal").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                            
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: "flame").resizable().frame(width: 20, height: 25).foregroundColor(Color("flame"))
                            Text("--").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("Kcal").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                        }
                        
                    }
                    
                    if workoutSession.distance != nil {
                        HStack(spacing: 8) {
                            Image(systemName: "ruler").resizable().resizable().frame(width: 25, height: 15).foregroundColor(Color("distance"))
                            Text(workoutSession.distanceFormatter()).font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("KM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                        }
                    } else {
                        HStack(spacing: 8) {
                            Image(systemName: "ruler").resizable().frame(width: 25, height: 15).foregroundColor(Color("distance"))
                            Text("--").font(.system(size: 25)).foregroundColor(Color("softWhite"))
                            Text("KM").font(.system(size: 20)).foregroundColor(Color("softWhite"))
                        }
                    }
                }
                
                Button {
                    workoutSession.resumeWorkout()
                } label: {
                    Text("RESUME").frame(maxWidth: 150, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("workoutControlPauseResume")).foregroundColor(Color("workoutControlFont")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                }.buttonStyle(PlainButtonStyle())
            }
//            HStack{
//                Circle()
//                    .frame(width: 8, height: 8)
//                    .foregroundColor(Color.white)
//                Circle()
//                    .frame(width: 8, height: 8)
//                    .foregroundColor(Color.gray)
//            }
        }
    }
}



//struct WorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkoutView().environmentObject(WorkoutSession())
//    }
//}
