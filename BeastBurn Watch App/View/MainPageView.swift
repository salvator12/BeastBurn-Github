//
//  mainView.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 22/05/23.
//

import SwiftUI

struct MainPageView: View {
    @State var ageInput: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                Image("mainBackground")
                VStack(spacing: 5) {
                    Spacer()
                    Text("BeastBurn").font(.system(size: 28, weight: .semibold)).foregroundColor(Color("softCream"))
                    HStack {
                        TextField("", text: $ageInput, prompt: Text("Your age").foregroundColor(Color.gray)).foregroundColor(Color("mainButton"))
                            .background(
                                RoundedRectangle(cornerRadius: 8.0)
                                    .stroke(Color("mainButton"), lineWidth: 5)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .frame(height: 40)
                            )
                            
                    }.frame(width: 160)
                    if ageInput != "" {
                        NavigationLink(destination: InfoView(ageInput: Int(ageInput) ?? 0), label: {
                            Text("NEXT").frame(maxWidth: 120, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("mainButton")).foregroundColor(Color("textColorMainButton")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                        }).buttonStyle(PlainButtonStyle())
                    } else {
                        Text("NEXT").frame(maxWidth: 120, maxHeight: 30).font(.system(size: 20, weight: .semibold)).background(Color("untouchMainButton")).foregroundColor(Color("textColorMainButton")).cornerRadius(8).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                    
                    
                }
            }.navigationBarHidden(true)
        }
        
    }
}

struct mainPageiew_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
