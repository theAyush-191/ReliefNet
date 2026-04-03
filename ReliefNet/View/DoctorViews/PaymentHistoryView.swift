//
//  CartView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 11/10/25.
//

import SwiftUI

struct PaymentHistoryView: View {
//    
//    var payments: [Appointment] = Appointments.appointments
//    
//    var paidTotal: Int {
//        payments.filter { $0.payment.isPaid }.map { Int($0.payment.amount) }.reduce(0, +)
//        }
//        
//        var unpaidTotal: Int {
//            payments.filter { !$0.payment.isPaid }.map { Int($0.payment.amount) }.reduce(0, +)
//        }
//        
    
    var body: some View {
        
//        var sortedBooking: [Booking] {
//            payments.sorted(by: { $0.payment.paymentDate > $1.payment.paymentDate })
//            }
//
//        
//        
//            VStack(spacing:0){
//                
//                ScrollView{
//                    LazyVStack(spacing: 12) {
//                        ForEach(sortedBooking) { booking in
//                            
//                            PaymentCard(booking: booking,payment: booking.payment)
//                            
//                        }
//                    }
//                    .padding(.horizontal, 10)
//                    .padding(.top, 10)
//                    
//                }
//                
//                VStack(spacing: 10){
//                    Text("Total Expenses").font(.headline)
//                    
//                    HStack{
//                        
//                        VStack(alignment: .leading, spacing:12){
//                            Text("Total Paid:")
//                            Text("Total Pending:")
//                            
//                        }.frame(maxWidth: .infinity,alignment: .leading)
//                        
//                        VStack(alignment: .leading, spacing:12){
//                            
//                            Text("₹\(paidTotal)")
//                            Text("₹\(unpaidTotal)")
//                            
//                        }.frame(maxWidth: .infinity,alignment: .trailing)
//                    }
//                }.padding(12).font(.subheadline).bold().frame(maxWidth: .infinity).background(Rectangle().fill(.gray.opacity(0.4)))
//            
//            }.padding(.horizontal,20).padding(.top,10)
//            .background(Color(.white)).padding(.top,1)
//            .navigationBarBackButtonHidden(false).navigationTitle("Payment History")
////                .
    }
}

//struct PaymentCard : View{
//    
//    var booking: Booking
//    var payment : PaymentData
//    var body: some View {
//        
//        let name = booking.doctorName
//        let date = payment.paymentDate
//        let price = payment.amount
//        var status : String{
//            if payment.isPaid{
//                return "Paid"
//            }
//            else{
//                return "Pending"
//            }
//        }
//        var statusColor : Color{
//            if payment.isPaid{
//                return .green
//            }
//            else{
//                return .red
//            }
//        }
//        
//        HStack(spacing:12){
//            
//            VStack(alignment: .leading){
//                Text(name).bold()
//                Text("\(date.formatted(date:.abbreviated,time: .omitted))").foregroundStyle(.gray)
//            }.frame(maxWidth: .infinity,alignment: .leading)
//            
//            VStack(alignment: .leading){
//                Text("₹\(price)").bold()
//                Text("\(status)").foregroundStyle(statusColor)
//            }.frame(maxWidth: .infinity,alignment:.trailing)
//            
//        }.padding(.horizontal,10).padding(.vertical,20).frame(maxWidth: .infinity)
//            .background( Rectangle().fill(.white))
//            
//            .shadow(color: .gray.opacity(0.3), radius: 10, y: 5)
//    }
//}
//
//#Preview {
//   PaymentHistoryView()
//}
