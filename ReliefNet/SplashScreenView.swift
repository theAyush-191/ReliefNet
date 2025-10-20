//
//  ContentView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 27/09/25.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            Image("appBG").resizable().scaledToFill().ignoresSafeArea()
            VStack(spacing:0) {
                Image("appLogo").resizable().aspectRatio(contentMode: .fit).frame(maxWidth: 100)
                    
                Text("ReliefNet").font(.system(size: 80,design: .serif)).foregroundStyle(.white)
                Text("Bridging Care, Compassion, and Connection").font(.system(size: 15,design: .serif)).foregroundStyle(.white)
            }
            .padding()
        }
        
    }
//    init()
//    {
//        for family in UIFont.familyNames {
//            print("Font family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("   \(name)")
//            }
//        }
//    }
}

#Preview {
    SplashScreenView()
}
