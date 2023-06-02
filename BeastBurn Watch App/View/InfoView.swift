//
//  InfoView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 22/05/23.
//

import SwiftUI

struct InfoView: View {
    @State var ageInput: Int = 0
    @State var maxHeartRate: String = ""
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                Text("How To Play").fontWeight(.semibold).foregroundColor(Color("softCream"))
                Text("you have to do some certain activity and let's your heart rate become your attack power to defeat the enemy. the amount of attack power based on how high your heart rate is").font(.system(size: 15)).foregroundColor(Color("softWhite"))
                Divider().frame(height: 1).overlay(Color("softCream"))
                Text("WARNING!!!").fontWeight(.semibold).foregroundColor(Color("softCream"))
                Text("if heart rate is greater than equal to \(calcMaxHeartRate()) or less than equal to 80, the monster will be healed").font(.system(size: 15)).foregroundColor(Color("softWhite"))
            }.frame(width: 160)
            Rectangle().fill(Color.black).frame(height: 1)
            NavigationLink(destination: CountdownView(ageInput: $ageInput, maxHeartRate: Int(maxHeartRate) ?? 0).navigationBarHidden(true).navigationBarBackButtonHidden(true), label: {
                Text("PLAY").frame(maxWidth: 120, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("mainButton")).foregroundColor(Color("textColorMainButton")).cornerRadius(8)
            }).buttonStyle(PlainButtonStyle())
        }.onAppear {
            print("age: \(ageInput)")
            maxHeartRate = calcMaxHeartRate()
            print("test \(maxHeartRate)")
        }
        
        
    }
    
    func calcMaxHeartRate() -> String {
        let max = Double((220-ageInput)) * 0.8
        let low = Double((220-ageInput)) * 0.6
        print(max)
        print(low)
        print(String(format: "%.0f", (max+low)/2))
        
        return String(format: "%.0f", (max+low)/2)
    }
}



struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(ageInput: 0)
    }
}
