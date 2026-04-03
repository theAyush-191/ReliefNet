//
//  RootView.swift
//  ReliefNet
//
//  Created by Ayush Singh on 26/03/26.
//
import SwiftUI

struct RootView: View {

    @EnvironmentObject var session: UserSession

    var body: some View {

        if !session.roleSelected {
            RoleSelectionView()

        } else if !session.isLoggedIn {

            if session.userType == .doctor {
                DoctorLoginView()
            } else {
                PatientLoginView()
            }

        } else {
            MainTabView()
        }
    }
}
