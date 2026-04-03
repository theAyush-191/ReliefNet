////
////  SessionCreationView.swift
////  ReliefNet
////
////  Created by Ayush Singh on 01/11/25.
////
//
////
////  SessionCreationView.swift
////  ReliefNet
////
////  Created by Ayush Singh on 01/11/25.
////
//
//import SwiftUIa
//
//// MARK: - Model
////struct DoctorSession: Identifiable, Hashable {
////    let id = UUID()
////    var days: [String]
////    var startTime: Date
////    var endTime: Date
////    var duration: Int
////}
//
//// MARK: - Main View
//struct SessionCreationView: View {
//    
//    @State private var sessions: [DoctorSession] = []
//    @State private var showForm = false
//    @State private var selectedDays: Set<String> = []
//    @State private var startTime = Date()
//    @State private var endTime = Date().addingTimeInterval(3600)
//    @State private var duration = 30
//    @State private var showAlert = false
//    
//    let allDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
//    let durations = [15, 30, 45, 60]
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                if !showForm {
//                    ScrollView {
//                        VStack(spacing: 20) {
//                            
//                            // MARK: - Existing Sessions
//                            if sessions.isEmpty {
//                                VStack(spacing: 16) {
//                                    Image(systemName: "calendar.badge.plus")
//                                        .font(.system(size: 60))
//                                        .foregroundColor(.blue)
//                                    Text("No sessions created yet")
//                                        .font(.title3)
//                                        .foregroundColor(.secondary)
//                                }
//                                .padding(.top, 60)
//                            } else {
//                                VStack(alignment: .leading, spacing: 16) {
//                                    Text("Your Sessions")
//                                        .font(.headline)
//                                        .padding(.horizontal)
//                                    
//                                    ForEach(sessions) { session in
//                                        SessionCard(session: session) {
//                                            if let index = sessions.firstIndex(of: session) {
//                                                sessions.remove(at: index)
//                                            }
//                                        }
//                                    }
//                                }
//                                .padding(.top)
//                            }
//                            
//                            // MARK: - Create Session Button
//                            Button(action: { showForm = true }) {
//                                Label("Create New Session", systemImage: "plus.circle.fill")
//                                    .fontWeight(.semibold)
//                                    .frame(maxWidth: .infinity)
//                                    .padding()
//                                    .background(Color.blue)
//                                    .foregroundColor(.white)
//                                    .cornerRadius(12)
//                                    .padding(.horizontal)
//                            }
//                            .padding(.top, 20)
//                        }
//                        .padding(.bottom, 60)
//                    }
//                    
//                } else {
//                    // MARK: - Creation Form
//                    Form {
//                        Section(header: Text("Select Available Days")) {
//                            VStack(alignment: .leading, spacing: 6) {
//                                ForEach(allDays, id: \.self) { day in
//                                    HStack {
//                                        Image(systemName: selectedDays.contains(day) ? "checkmark.circle.fill" : "circle")
//                                            .foregroundColor(selectedDays.contains(day) ? .blue : .gray)
//                                            .onTapGesture {
//                                                if selectedDays.contains(day) {
//                                                    selectedDays.remove(day)
//                                                } else {
//                                                    selectedDays.insert(day)
//                                                }
//                                            }
//                                        Text(day)
//                                    }
//                                }
//                            }
//                            .padding(.vertical, 6)
//                        }
//                        
//                        Section(header: Text("Set Availability Time")) {
//                            DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
//                            DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
//                        }
//                        
//                        Section(header: Text("Session Duration")) {
//                            Picker("Duration (minutes)", selection: $duration) {
//                                ForEach(durations, id: \.self) { d in
//                                    Text("\(d) mins").tag(d)
//                                }
//                            }
//                            .pickerStyle(.segmented)
//                        }
//                        
//                        Section {
//                            Button(action: saveSession) {
//                                HStack {
//                                    Spacer()
//                                    Text("Save Session")
//                                        .fontWeight(.bold)
//                                    Spacer()
//                                }
//                            }
//                            .buttonStyle(.borderedProminent)
//                            .tint(.blue)
//                        }
//                    }
//                    .transition(.move(edge: .bottom))
//                }
//            }
//            .navigationTitle("Doctor Availability")
//            .animation(.easeInOut, value: showForm)
//            .alert("Session Added ✅", isPresented: $showAlert) {
//                Button("OK", role: .cancel) { }
//            } message: {
//                Text("Availability added for \(selectedDays.joined(separator: ", ")).")
//            }
//        }
//    }
//    
//    // MARK: - Functions
//    func saveSession() {
//        guard !selectedDays.isEmpty else { return }
//        let newSession = DoctorSession(days: Array(selectedDays),
//                                       startTime: startTime,
//                                       endTime: endTime,
//                                       duration: duration)
//        sessions.append(newSession)
//        resetForm()
//        showAlert = true
//    }
//    
//    func resetForm() {
//        selectedDays.removeAll()
//        startTime = Date()
//        endTime = Date().addingTimeInterval(3600)
//        duration = 30
//        showForm = false
//    }
//}
//
//// MARK: - Session Card View
//struct SessionCard: View {
//    var session: DoctorSession
//    var onDelete: () -> Void
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text(session.days.joined(separator: ", "))
//                    .font(.headline)
//                Spacer()
//                Button(action: onDelete) {
//                    Image(systemName: "trash.fill")
//                        .foregroundColor(.red)
//                }
//            }
//            
//            Text("⏰ \(formattedTime(session.startTime)) - \(formattedTime(session.endTime))")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//            
//            Text("⌛ Duration: \(session.duration) mins")
//                .font(.subheadline)
//                .foregroundColor(.secondary)
//        }
//        .padding()
//        .background(Color(.systemGray6))
//        .cornerRadius(14)
//        .shadow(color: .gray.opacity(0.1), radius: 3, x: 0, y: 2)
//        .padding(.horizontal)
//    }
//    
//    func formattedTime(_ date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        return formatter.string(from: date)
//    }
//}
//
//// MARK: - Preview
//#Preview {
//    SessionCreationView()
//}
