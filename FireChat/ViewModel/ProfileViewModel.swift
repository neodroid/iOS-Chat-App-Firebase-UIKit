//
//  ProfileViewModel.swift
//  FireChat
//
//  Created by Kevin ahmad on 05/06/22.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    
    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Settings"
        }
    }
    
    var iconImage: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }
    
}
