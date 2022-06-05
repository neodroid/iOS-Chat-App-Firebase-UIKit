//
//  ProfileCell.swift
//  FireChat
//
//  Created by Kevin ahmad on 05/06/22.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    
    var viewModel: ProfileViewModel? {
        didSet {configure() }
    }
    //MARK: - Properties
    
    private lazy var iconView: UIView = {
        let view = UIView()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.centerY(inView: view)
        
        view.backgroundColor = .systemCyan
        view.setDimensions(width: 40, height: 40)
        view.layer.cornerRadius = 40 / 2
        
        return view
    }()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 28, height: 28)
        iv.tintColor = .white
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stack = UIStackView(arrangedSubviews: [iconView,titleLabel])
        stack.spacing = 8
        stack.axis = .horizontal
        
        addSubview(stack)
        stack.centerY(inView: self,leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configure() {
        guard let viewModel = viewModel else { return  }
        
        iconImage.image = UIImage(systemName: viewModel.iconImage)
        titleLabel.text = viewModel.description
    }
    
}


