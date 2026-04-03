//
//  AudioCallView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 20/10/25.
//

import SwiftUI

// MARK: - Audio Call View
struct AudioCallView: View {
    @Environment(\.dismiss) private var dismiss
    var doctorName: String
    var doctorImageName: String


    // State for call controls
    @State private var isMuted: Bool = false
    @State private var isSpeaker: Bool = false
    
    // State for the timer
    @State private var elapsedSeconds: Int = 0
    @State private var timer: Timer? = nil

    // Formats the time into MM:SS
    private var formattedTime: String {
        let minutes = elapsedSeconds / 60
        let seconds = elapsedSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack {

            Image("appBG")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(.black.opacity(0.3))

            VStack {
                
                Spacer()

                // MARK: - Profile Section
                VStack(spacing: 15) {
                    Image(doctorImageName) // Placeholder image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.5), lineWidth: 3)
                        )
                        .shadow(radius: 10)
                    
                    Text(doctorName)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Live call timer
                    Text(formattedTime)
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .fontDesign(.monospaced)
                }
                
                Spacer()
                Spacer()

                // MARK: - Control Buttons
                HStack(spacing: 50) {
                    // Mute Button
                    AudioControlButton(
                        iconName: isMuted ? "mic.slash.fill" : "mic.fill",
                        label: "Mute",
                        isTapped: $isMuted
                    )
                    
                    // Speaker Button
                    AudioControlButton(
                        iconName: isSpeaker ? "speaker.wave.2.fill" : "speaker.fill",
                        label: "Speaker",
                        isTapped: $isSpeaker
                    )
                }
                .padding(.bottom, 40)
                
                // End Call Button
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "phone.down.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 70, height: 70)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .navigationBarBackButtonHidden(false)
        .statusBarHidden(true).toolbar {
            ToolbarItem(placement: .principal) {
                Text("Voice Call").font(.system(size:20,)).foregroundStyle(.gray)
            }
        }
    }
    
    // MARK: - Timer Functions
    private func startTimer() {
        timer?.invalidate() // Stop any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            elapsedSeconds += 1
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - Reusable Audio Control Button
struct AudioControlButton: View {
    let iconName: String
    let label: String
    @Binding var isTapped: Bool

    var body: some View {
        Button {
            isTapped.toggle()
        } label: {
            VStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .frame(width: 60, height: 60)
                    .background(
                        isTapped ? Color.white.opacity(0.9) : Color.white.opacity(0.2)
                    )
                    .clipShape(Circle())
                    .foregroundColor(isTapped ? .black : .white)
                
                Text(label)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AudioCallView(
        doctorName: "Dr. Rahul Verma",
        doctorImageName: "doctorPic" // Make sure this image is in your Assets
    )
}
