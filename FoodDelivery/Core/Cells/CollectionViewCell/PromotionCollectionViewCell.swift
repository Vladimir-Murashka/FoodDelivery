//
//  PromotionCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Swift Learning on 21.10.2022.
//

import UIKit

final class PromotionCollectionViewCell: UICollectionViewCell {
    
    // MARK: - PrivateProperties
    
    private let promotiontImageView = make(UIImageView()) { imageView in
        imageView.backgroundColor = .lightGray
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PublicMethods
    
    func configureCell(with viewModel: PromotionCollectionViewCellViewModel) {
        // TODO: - load image by url
    }
}

// MARK: - PrivateMethods

private extension PromotionCollectionViewCell {
    func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        contentView.addSubviews(promotiontImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            promotiontImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            promotiontImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            promotiontImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            promotiontImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}

