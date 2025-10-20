//
//  LoadingView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

import SwiftUI
import Combine

struct LoadingView: View {
    @State private var progress: Double = 0.0
    @State private var isLoading: Bool = false
    @State private var timer: Cancellable? = nil
    
    @EnvironmentObject var session: UserSession
    var body: some View {
        ZStack {
            Image("appBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle())
                    .tint(.purple)
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .padding(50)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isLoading) {
            
                RoleSelectionView()
                    .environmentObject(session) // ensure session is passed
        
        }
        .onAppear {
            startLoading()
        }
        .onDisappear {
            timer?.cancel()
        }
    }

    private func startLoading() {
        progress = 0.0
        isLoading = false

        timer?.cancel() // cancel previous timer if any
        timer = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if progress < 1.0 {
                    progress += 0.01
                } else {
                    isLoading = true
                    timer?.cancel() // stop the timer
                }
            }
    }
}

#Preview {
    NavigationStack {
        LoadingView()
            .environmentObject(UserSession())
    }
}
