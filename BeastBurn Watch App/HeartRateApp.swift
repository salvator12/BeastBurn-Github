//
//  HeartRateApp.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 18/05/23.
//

import SwiftUI

@main
struct HeartRate_Watch_AppApp: App {
    @StateObject var highscoreController = HSController()
    @StateObject var workOutSession = WorkoutSession()
    init() {
        workOutSession.setupSession()
    }
    var body: some Scene {
        WindowGroup {
            MainPageView().environment(\.managedObjectContext, highscoreController.container.viewContext).environmentObject(workOutSession)
        }
    }
}
