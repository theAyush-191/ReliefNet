//
//  VideoCallView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 20/10/25.
//

import SwiftUI

struct VideoCallView: View {
    @Environment(\.dismiss) private var dismiss
    var doctorName: String
    
    @State var isMicOn: Bool = false
     @State var isVideoOn: Bool = false
    
    //Add state for the timer ---
        @State private var elapsedSeconds: Int = 0
        @State private var timer: Timer? = nil

   //Add a helper to format the time ---
        private var formattedTime: String {
            let minutes = elapsedSeconds / 60
            let seconds = elapsedSeconds % 60
            // %02d ensures leading zeros, e.g., "01:05"
            return String(format: "%02d:%02d min", minutes, seconds)
        }
    
    var body: some View {
 

        
        
        ZStack {
            // MARK: - Main Video View (Doctor)
            Image("appBG") // Replace with your actual image asset for the doctor
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                // MARK: - Header
                HStack {

                    Spacer()

                    // Picture-in-Picture placeholder for patient
                    // This is positioned in the header for now, but could be separate
                    // MARK: - Picture-in-Picture View (Patient)
                    Image("patientImage") // Replace with your actual image asset for the patient
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 160) // Adjust size as needed
                        .cornerRadius(10)
                        .clipped() // Ensures content doesn't spill out
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white.opacity(0.5), lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                .padding(.top, 50) // Adjust for status bar
                
Spacer()

                // MARK: - Control Buttons
                VStack(spacing: 20) {

                    HStack(spacing: 30) {
                        Button(action:{isMicOn.toggle()}){
                            CallControlButton(iconName: "mic.slash.fill", label: "Mute", isTapped: isMicOn) }
                        // Mic (muted)
                        Button(action:{isVideoOn.toggle()}){
                            CallControlButton(iconName: "video.slash.fill", label: "Camera Off", isTapped: isVideoOn)
                        }
                        // Camera (off)
                        NavigationLink(destination:ChatDetailedView(chatTitle: doctorName)){
                            CallControlButton(iconName: "message.fill", label: "Chat", isTapped: false)
                        } // Chat
                        
                        Button(action:{dismiss()}){
                            CallControlButton(iconName: "phone.down.fill", label: "End", isTapped: true) // End Call
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 15) // Space from bottom edge
                }
                .padding(.vertical, 20) // Vertical padding within the control background
                .frame(maxWidth: .infinity)
                .background(Color.black.opacity(0.8)).cornerRadius(20)
            }.background(
                Image("doctorPic").resizable().ignoresSafeArea().scaledToFill()
            ).padding(.top,1).safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 20)
            }
        }.onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .navigationBarBackButtonHidden(false)
        .statusBarHidden(true).toolbar {
            ToolbarItem(placement: .principal) {
                Text(doctorName).font(.system(size:20))
            }
            if #available(iOS 26.0, *) {
                ToolbarItem(placement: .subtitle) {
                    Text(formattedTime).font(.callout)
                }
            } else {
                ToolbarItem(placement: .automatic) {
                    Text(formattedTime).font(.callout)
                }
            }
        }
    }
    private func startTimer() {
            // Ensure no old timer is running
            timer?.invalidate()
            // Start a new timer that fires every 1 second
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                elapsedSeconds += 1
            }
        }

        private func stopTimer() {
            // Stop the timer and release it
            timer?.invalidate()
            timer = nil
        }
    
        
}

// MARK: - Reusable Call Control Button
struct CallControlButton: View {
    let iconName: String
    let label: String
    let isTapped: Bool // For the end call button

    var body: some View {
        VStack {
            if iconName=="phone.down.fill"{
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(isTapped ? Color.red : Color.gray.opacity(0.7))
                    .clipShape(Circle())
            }else{
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(isTapped ? Color.blue : Color.gray.opacity(0.7))
                    .clipShape(Circle())
            }
            
            
            
            // If you want labels, uncomment this:
            // Text(label)
            //     .font(.caption)
            //     .foregroundColor(.white)
        }
    }
}


// MARK: - Preview
#Preview {
    VideoCallView(doctorName:"Dr.Paramjeet")
}
