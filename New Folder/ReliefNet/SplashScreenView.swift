import SwiftUI
import Combine

struct SplashScreenView: View {
    @State private var isLoaded: Bool = false
    @State private var timer: AnyCancellable? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Image("appBG")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Image("appLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100)

                    Text("ReliefNet")
                        .font(.system(size: 80, design: .serif))
                        .foregroundStyle(.white)

                    Text("Bridging Care, Compassion, and Connection")
                        .font(.system(size: 15, design: .serif))
                        .foregroundStyle(.white)
                }
                .padding()
            }
            .onAppear {
                // Move to login screen after 2 seconds
                timer = Timer.publish(every: 2, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        isLoaded = true
                        timer?.cancel()
                    }
            }
            .navigationDestination(isPresented: $isLoaded) {
                RootView()
                
            }
        }
    }
}
