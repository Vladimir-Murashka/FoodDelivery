//
//  CityBarButtonView.swift
//  FoodDelivery
//
//  Created by Swift Learning on 18.10.2022.
//

import UIKit

final class CityBarButtonView: UIView {
    
    private let cityLabel = make(UILabel()) { label in
        label.font = .systemFont(
            ofSize: 17,
            weight: .medium
        )
    }
    
    private let cityImage = make(UIImageView()) { imageView in
        let image = UIImage(systemName: "chevron.down")?.withTintColor(
            .black,
            renderingMode: .alwaysOriginal
        )
        imageView.image = image
    }
    
    private let stackView = make(UIStackView()) { stackView in
        stackView.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        cityLabel.text = title
    }
}

private extension CityBarButtonView {
    func setupView() {
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        addSubviews(stackView)
        
        stackView.addArrangedSubviews(
            cityLabel,
            cityImage
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
