//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 22.03.2023.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = Images.placehloder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(fromURL url: String) {
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
}
