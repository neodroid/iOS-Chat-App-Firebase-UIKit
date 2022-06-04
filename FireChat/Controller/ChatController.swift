//
//  ChatController.swift
//  FireChat
//
//  Created by Kevin ahmad on 05/06/22.
//

import UIKit

class ChatController: UICollectionViewController {
    
    // MARK: - properties
    
    // MARK: - lifecycle
    
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - helpers
    func configureUI() {
        collectionView.backgroundColor = .white
    }
    
}
