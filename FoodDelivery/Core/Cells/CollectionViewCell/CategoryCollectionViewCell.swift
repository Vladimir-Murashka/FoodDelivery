//
//  CategoryCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Swift Learning on 21.10.2022.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - PrivateProperties
    
    private let titleLabel = make(UILabel()) { label in
        label.layer.cornerRadius = 16
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.purple.cgColor
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
    
    func configureCell(with viewModel: CategoryCellViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.layer.borderWidth = viewModel.isSelected ? 0 : 1
        titleLabel.backgroundColor = viewModel.isSelected ? .systemPink : .clear
    }
}

// MARK: - PrivateMethods

private extension CategoryCollectionViewCell {
    func setupCell() {
        setupContentView()
        addSubViews()
        setupConstraints()
    }
    
    func setupContentView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    func addSubViews() {
        contentView.addSubviews(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}
