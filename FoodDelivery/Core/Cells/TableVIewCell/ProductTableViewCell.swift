//
//  ProductTableViewCell.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {
    
    // MARK: - PrivateProperties
    
    private let productImageView = make(UIImageView()) { imageView in
        imageView.backgroundColor = .lightGray
    }
    
    private let titleLabel = make(UILabel()) { label in
        label.font = .systemFont(
            ofSize: 20,
            weight: .bold
        )
        label.numberOfLines = 0
    }
    
    private let descpritionLabel = make(UILabel()) { label in
        label.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        label.numberOfLines = 0
    }
    
    private lazy var priceButton = make(UIButton()) { button in
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.purple.cgColor
        button.addTarget(
            self,
            action: #selector(didTapPriceButton),
            for: .touchUpInside
        )
        
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .purple
        config.contentInsets = .init(
            top: 8,
            leading: 18,
            bottom: 8,
            trailing: 18
        )
        button.configuration = config
    }
    
    // MARK: - Initializer
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PublicMethods
    
    func configureCell(with viewModel: ProductCellViewModel) {
        titleLabel.text = viewModel.title
        descpritionLabel.text = viewModel.descpition
        
        priceButton.setTitle(
            viewModel.price,
            for: .normal
        )

        productImageView.setImage(urlString: viewModel.imageUrl)
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapPriceButton() {
        print(#function)
    }
}

// MARK: - PrivateMethods

private extension ProductTableViewCell {
    func setupCell() {
        backgroundColor = .systemBackground
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        contentView.addSubviews(
            productImageView,
            titleLabel,
            descpritionLabel,
            priceButton
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            productImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            productImageView.heightAnchor.constraint(equalToConstant: 132),
            productImageView.widthAnchor.constraint(equalToConstant: 132),
            productImageView.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -24
            ),
            
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 16
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: 32
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            descpritionLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8
            ),
            descpritionLabel.leadingAnchor.constraint(
                equalTo: productImageView.trailingAnchor,
                constant: 32
            ),
            descpritionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            
            priceButton.topAnchor.constraint(
                equalTo: descpritionLabel.bottomAnchor,
                constant: 16
            ),
            priceButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -24
            ),
            priceButton.bottomAnchor.constraint(
                lessThanOrEqualTo: contentView.bottomAnchor,
                constant: -24
            ),
            priceButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
