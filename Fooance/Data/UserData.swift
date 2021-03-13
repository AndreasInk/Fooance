//
//  UserData.swift
//  Fooance
//
//  Created by Andreas on 3/13/21.
//

import Foundation
import SwiftUI
import Combine

final class UserData: ObservableObject {
    
    public static let shared = UserData()
    
    @Published(key: "firstRun")
    var firstRun: Bool = true
    
    @Published(key: "isOnboardingCompleted")
    var isOnboardingCompleted: Bool = false
    
    @Published(key: "isSetupCompleted")
    var isSetupCompleted: Bool = false
    
    @Published(key: "name")
    var name: String = "nil"
    
    @Published(key: "userID")
    var userID: String = "\(UUID())"
    
    @Published(key: "monthlyBudget")
    var monthlyBudget: Double = 0.0
    
 
}


