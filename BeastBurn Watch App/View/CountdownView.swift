//
//  CountdownView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 23/05/23.
//

import SwiftUI

struct CountdownView: View {
    @State private var scale = 0.5
    @State private var count = 4
    @State private var fadeIn = false
    @ObservedObject var soundController = SoundController()
    @Binding var ageInput: Int
    
    var maxHeartRate: Int = 0
    let countdownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if count == 0 {
            CoreFeaturesView(ageInput: $ageInput, maxHeartRate: maxHeartRate).opacity(fadeIn ? 1 : 0).onAppear {
                withAnimation(Animation.easeIn(duration: 1.0)) {
                    fadeIn.toggle()
                }
            }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
        } else {
            Text("\(count == 4 ? "Ready" : String(count))").foregroundColor(Color("mainButton")).font(.system(size: count == 4 ? 70 : 100)).scaleEffect(scale)
                .onReceive(countdownTimer) { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if count-1 == 3 {
                            soundController.countdown3()
                        }
                        if count-1 == 2 {
                            soundController.countdown2()
                        }
                        if count-1 == 1 {
                            soundController.countdown1()
                        }
                        if count-1 == 0 {
                            soundController.countdownGo()
                        }
                        count -= 1
                        
                    }
                }
                .onChange(of: count) { newValue in
                    if count > 0 && scale == 0.5 {
                        let animation = Animation.easeInOut(duration: 1.0)
                        withAnimation(animation) {
                            scale = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                            scale = 0.5
                        }
                    }
                }
            
        }
        
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(ageInput: .constant(0))
    }
}
