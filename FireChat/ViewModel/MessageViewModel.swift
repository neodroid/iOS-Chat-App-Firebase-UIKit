//
//  MessageViewModel.swift
//  FireChat
//
//  Created by Kevin ahmad on 05/06/22.
//

import Foundation
import UIKit

struct MessageViewModel {
    
    private let message:Message
    
    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? UIColor(red: 0.278, green: 0.561, blue: 0.965, alpha: 1.0) : UIColor(red: 0.914, green: 0.914, blue: 0.922, alpha: 1.0)
        
    }
    
    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .white : .black 
    }
    
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl: URL? {
        guard let user = message.user else {return nil}
        return URL(string: user.profileImageUrl)
    }
    
    init(message: Message){
        self.message = message
    }
}
