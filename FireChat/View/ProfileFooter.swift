//
//  ProfileFooter.swift
//  FireChat
//
//  Created by Kevin ahmad on 05/06/22.
//

import UIKit

protocol ProfileFooterDelegate: class {
    func handleLogout()
}

class ProfileFooter: UIView {
    
    weak var delegate: ProfileFooterDelegate?
    
    //MARK: - Properties
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoutButton)
        logoutButton.anchor(left:leftAnchor, right: rightAnchor, paddingLeft: 32,paddingRight: 32)
        logoutButton.centerY(inView: self)
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleLogout() {
        delegate?.handleLogout()
    }
    
}
