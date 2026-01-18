//
//  LoadingView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 28/09/25.
//

//
//  LoadingView.swift
//  ReliefNet
//

import SwiftUI
import Combine

struct LoadingView: View {

    @State private var progress: Double = 0.0
    @State private var timer: Cancellable?

    @EnvironmentObject var session: UserSession

    var body: some View {
        ZStack {
            Image("appBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle())
                .tint(.purple)
                .scaleEffect(x: 1, y: 2)
                .padding(50)
        }
        .onAppear {
            startLoading()
        }
        .onDisappear {
            timer?.cancel()
        }
    }

    private func startLoading() {
        progress = 0
        timer?.cancel()

        timer = Timer.publish(every: 0.03, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if progress < 1.0 {
                    progress += 0.02
                } else {
                    timer?.cancel()

                    // ✅ ONLY update tab state
                    session.selectedTab =
                        session.userType == "Doctor" ? .doctorHome : .home
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
