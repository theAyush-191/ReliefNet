//
//  DiscoverView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 01/10/25.
//

import SwiftUI

struct DiscoverView: View {
    @State private var selectedTab = "Psychologist"
    @State private var selectedFilter = "All Professionals"
    
    var body: some View {
        ZStack{
            Image("appBG").resizable().scaledToFill().ignoresSafeArea()
            ScrollView{
                VStack{
                    SearchBarView().padding(.horizontal,20).padding(.top,10)
                    NavigationLink(destination: HealthSupportView()){
                        HStack{
                            VStack(alignment: .leading, spacing:8){
                                Text("Mental Health Support").font(.system(size:20,weight: .medium,design: .serif))
                                
                                Text("Connect with verified therapists and counselors in your preferred language.").font(.subheadline).fontWeight(.thin).fixedSize(horizontal: false, vertical: true)
                            }
                            Image(systemName: "arrow.right").resizable().frame(width: 35, height: 30)
                            
                        }.padding().background(RoundedRectangle(cornerRadius: 12).fill(.purple.opacity(0.3))).padding(.vertical,20)
                    }.tint(.black)
                    HStack(spacing: 0) {
                        ForEach(["Psychologist", "Therapist", "Psychiatrist"], id: \.self) { tab in
                            VStack {
                                Text(tab)
                                    .font(.headline)
                                    .fontWeight(selectedTab == tab ? .medium : .light)
                                    .foregroundColor(selectedTab == tab ? .blue : .black.opacity(0.6))
                                if selectedTab == tab {
                                    Rectangle()
                                        .fill(Color.blue)
                                        .frame(height: 2)
                                        .matchedGeometryEffect(id: "underline", in: Namespace().wrappedValue)
                                } else {
                                    
                                        Rectangle()
                                            .fill(Color.black.opacity(0.4))
                                            .frame(height: 2)
                                        
                                    
                                }
                                
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedTab = tab
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
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
                        
                        ForEach(doctorsData){doctor in
                            if selectedTab == doctor.category {
                                NavigationLink(destination: DoctorDetailView(data: doctor)){
                                    ProfessionalCard(data: doctor)
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
    
    var data:DoctorData
    


    var body: some View {
        
        let name: String = data.name
        let role: String = data.role
        let experience: Int = data.experience
        let price: Int = data.price
        let rating: Double = data.rating
        let reviews: Int = data.reviews
        
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                    .overlay(Text("80\n80").font(.caption2).foregroundColor(.gray))

                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Text(role)
                        .font(.subheadline).lineLimit(1)
                        .foregroundColor(.gray)

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        Text("\(String(format: "%.1f", rating))")
                            .font(.caption)
                            .foregroundColor(.black)
                        Text("(\(reviews) reviews)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()
            }

            HStack {
                VStack(alignment: .leading) {
                    Text("\(experience)+ years")
                        .font(.caption)
                        .foregroundColor(Color(.black.opacity(0.8)))
                    Text("Experience")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading) {
                    Text("₹ \(price) / Session")
                        .font(.caption)
                        .foregroundColor(Color(.black.opacity(0.8)))
                    Text("Start at")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()

                
            }
            HStack{
                Button(action: {}) {
                    Text("Book Session")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(Color.darkPurple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }


            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 2)
    }
}


#Preview {
    DiscoverView()
}
