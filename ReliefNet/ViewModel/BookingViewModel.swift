//
//  BookingViewModel.swift
//  ReliefNet
//
//  Created by Ayush Singh on 07/04/26.
//

import Foundation
import Combine

class BookingViewModel:ObservableObject{
    @Published var bookings: [Appointment] = Appointments.appointments
    
    
}
