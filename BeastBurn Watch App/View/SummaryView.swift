//
//  SummaryView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 24/05/23.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var workoutSession: WorkoutSession
    @Environment(\.managedObjectContext) var manageObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.age, order: .reverse)]) var highscoreResult: FetchedResults<Highscore>
    @Binding var countTimer: Int
    @State var highscoreDicts: [String: Int] = [:]
    var maxHeartRate: Int = 0
    var percentHealth: Int = 15000
    @Binding var ageInput: Int
    var body: some View {
        NavigationView {
            VStack {
                Text("Summary").font(.system(size: 18).bold()).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 100))
                ScrollView {
                    VStack(spacing: 3) {
                        Text(percentHealth >= 15000 ? "Game Over!!" : "You Win!!!").font(.system(size: 17).bold()).foregroundColor(Color("mainButton"))
                        if percentHealth >= 15000 {
                            Text("highScore: \(highscoreDicts[String(ageInput)] ?? 0)").font(.system(size: 15).bold())
                        } else {
                            Text("Score: \(4000 - countTimer)").font(.system(size: 15))
                            Text("HighScore: \(highscoreDicts[String(ageInput)] ?? 0 == 0 ? 4000 - countTimer : highscoreDicts[String(ageInput)] ?? 0)").font(.system(size: 15))
                        }
                        
                    }
                    Rectangle().fill(Color.black)
                    HStack {
                        ZStack {
                            Rectangle().fill(Color.red).opacity(0.58).cornerRadius(8).frame(width: 50, height: 55)
                            VStack {
                                Text(workoutSession.avgHeartBeatFormatter()).font(.system(size: 17).bold())
                                Text("BPM").font(.system(size: 15))
                            }
                        }
                        
                        ZStack {
                            Rectangle().fill(Color("distance")).opacity(0.58).cornerRadius(8).frame(width: 50, height: 55)
                            VStack {
                                Text(workoutSession.distanceFormatter()).font(.system(size: 17).bold())
                                Text("KM").font(.system(size: 15))
                            }
                        }
                        
                        ZStack {
                            Rectangle().fill(Color("flame")).opacity(0.58).cornerRadius(8).frame(width: 50, height: 55)
                            VStack {
                                Text(workoutSession.kcalFormatter()).font(.system(size: 17).bold())
                                Text("Kcal").font(.system(size: 15))
                            }
                        }
                        
                    }
                    Rectangle().fill(Color.black)
                    NavigationLink(destination: MainPageView().navigationBarHidden(true).navigationBarBackButtonHidden(true), label: {
                        Text("DONE").frame(maxWidth: 120, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("mainButton")).foregroundColor(Color("textColorMainButton")).cornerRadius(8)
                    }).buttonStyle(PlainButtonStyle())
                }
            }
        }.onAppear {
            if !highscoreResult.isEmpty {
                for highscore in highscoreResult {
                    highscoreDicts[String(highscore.age)] = Int(highscore.highscore)
                }
                
                if percentHealth != 15000 {
                    let score = 4000 - countTimer
                    
                    if highscoreDicts[String(ageInput)] == nil {
                        highscoreDicts[String(ageInput)] = score
                    } else if score > highscoreDicts[String(ageInput)] ?? 0 {
                        highscoreDicts.updateValue(score, forKey: String(ageInput))
                    }
                }
            } else {
                let highscore = Highscore(context: manageObjContext)
                highscore.age = Int32(ageInput)
                highscore.highscore = Int32(4000 - countTimer)
                highscoreDicts[String(highscore.age)] = Int(highscore.highscore)
            }
            do {
                try manageObjContext.save()
            } catch{
                print(error.localizedDescription)
            }
        }.navigationBarHidden(true)
        
    }
}

//struct SummaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummaryView()
//    }
//}
