//
//  DiscoverView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 01/10/25.
//

import SwiftUI

struct DiscoverView: View {
    @State private var selectedTab: DoctorCategory = .psychologist
    @State private var selectedFilter = "All Professionals"
    @State var doctors = Doctors.doctorsData
    
    @Namespace var animation
    
    var body: some View {
        ZStack{
            Image("appBG").resizable().scaledToFill().ignoresSafeArea()
            ScrollView{
                VStack(spacing:15){
                    
                    SearchBarView().padding(.horizontal,20).padding(.top,10)
                    //
                    //
                    //                    NavigationLink(destination: HealthSupportView()){
                    //                        HStack{
                    //                            VStack(alignment: .leading, spacing:8){
                    //                                Text("Mental Health Support").font(.system(size:20,weight: .medium,design: .serif))
                    //
                    //                                Text("Connect with verified therapists and counselors in your preferred language.").font(.subheadline).fontWeight(.thin).fixedSize(horizontal: false, vertical: true)
                    //                            }
                    //                            Image(systemName: "arrow.right").resizable().frame(width: 35, height: 30)
                    //
                    //                        }.padding().background(RoundedRectangle(cornerRadius: 12).fill(.purple.opacity(0.3))).padding(.vertical,20)
                    //                    }.tint(.black)
                    //
                    
                    Category(selectedTab:$selectedTab)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 12) {
                                                            FilterButton(title: "All Professionals", selected: $selectedFilter)
                                                            FilterButton(title: "Near Me", selected: $selectedFilter)
                                                            FilterButton(title: "Top Rated", selected: $selectedFilter)
                                                            FilterButton(title: "Price", selected: $selectedFilter)
                                                        }
                                                        .padding(.horizontal)
                        }
                    VStack(spacing:16){
                        
//                      /*  let filteredDoctors = doctors.filter({$0.category == */selectedTab})
                        
                    ForEach(doctors.indices,id: \.self){index in
                        if doctors[index].category == selectedTab{
                        NavigationLink(destination: DoctorDetailView(data: $doctors[index])){
                            ProfessionalCard(data: $doctors[index])
                        }
                    }
                        }
                        
                    }.padding(.horizontal)
                }
            }.background(Color(.systemGroupedBackground)).padding(.top,20).safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 20) 
            }
        }.navigationBarBackButtonHidden(false)
    }
}

//MARK: - Reusable Components

struct SearchBarView: View {
    @State var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Find Near by Home care nurses........", text: $searchText)
            
        }.onSubmit {
            searchText = ""
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5, y: 2)
    }
}

struct Category: View {

    @Binding var selectedTab: DoctorCategory
    @Namespace private var animation

    var body: some View {

        ScrollView(.horizontal) {
            HStack(spacing: 0) {

                ForEach(DoctorCategory.allCases, id: \.self) { tab in
                    CategoryItem(
                        tab: tab,
                        selectedTab: $selectedTab,
                        animation: animation
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CategoryItem: View {

    let tab: DoctorCategory
    @Binding var selectedTab: DoctorCategory
    var animation: Namespace.ID

    var isSelected: Bool {
        selectedTab == tab
    }

    var body: some View {

        VStack(spacing: 6) {

            Text(tab.rawValue)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .white : .black)

                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    isSelected ? Color.blue : Color.white
                )
                .cornerRadius(20)

            Rectangle()
                .fill(isSelected ? Color.blue : Color.clear)
                .frame(height: 2)
                .matchedGeometryEffect(id: "underline", in: animation)
        }
        .padding(.horizontal, 4)
        .onTapGesture {
            withAnimation(.spring()) {
                selectedTab = tab
            }
        }
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool,
                             transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
// MARK: - Filter Button
struct FilterButton: View {
    var title: String
    @Binding var selected: String

    var body: some View {
        Button(action: {
            selected = title
        }) {
            Text(title).foregroundStyle(selected == title ? .darkPurple: .black)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(selected == title ? Color.purple.opacity(0.3) : Color(.white))
                .foregroundColor(.black)
                .cornerRadius(20)
        }
    }
}

// MARK: - Professional Card
struct ProfessionalCard: View {
    
    @Binding var data: Doctor
    
    var body: some View {
        
        let name = data.name
        let category = data.category.rawValue
        let experience = data.experience
        let price = data.consultationOptions.first?.price ?? 0
        let rating = data.rating
        let reviews = data.reviews
        
        // Example availability
        let availability = data.availability
        
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: Top Section
            HStack(alignment: .top, spacing: 14) {
                
                // Doctor Avatar
                ZStack(alignment: .bottomTrailing) {
                    
                    Circle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 70, height: 70)
                        .overlay(
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.gray)
                                .padding(10)
                        )
                    
                    // Availability Dot
                    Circle()
                        .fill(statusColor(availability))
                        .frame(width: 14, height: 14)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                        )
                }
                
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(category)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    // Rating
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                            .fontWeight(.medium)
                        
                        Text("(\(reviews))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // Availability Text
                    HStack(spacing: 6) {
                        Circle()
                            .fill(statusColor(availability))
                            .frame(width: 8, height: 8)
                        
                        Text(availabilityStatus(availability))
                            .font(.caption)
                            .foregroundColor(statusColor(availability))
                    }
                }
                
                Spacer()
            }
            
            
            Divider()
            
            
            // MARK: Info Section
            HStack {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(experience)+ yrs")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("Experience")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("₹ \(price)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    Text("Per Session")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Book")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .background(Color.darkPurple)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.08), radius: 6, y: 3)
        )
    }
    func statusColor(_ status: AvailabilityStatus) -> Color {
        
        switch status {
            
        case .available:
            return .green
            
        case .busy:
            return .red
            
        case .offline:
            return .gray
            
        default:
            return .gray
        }
    }
    
    func availabilityStatus(_ status: AvailabilityStatus) -> String {
        
        switch status {
            
        case .available:
            return "Available"
            
        case .busy:
            return "Busy"
            
        case .offline:
            return "Offline"
            
        default:
            return "Offline"
        }
    }
    
}


#Preview {
    DiscoverView()
}
