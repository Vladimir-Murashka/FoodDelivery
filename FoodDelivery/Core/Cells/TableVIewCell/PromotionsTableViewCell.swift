//
//  PromotionsTableViewCell.swift
//  FoodDelivery
//
//  Created by Swift Learning on 21.10.2022.
//

import UIKit

final class PromotionsTableViewCell: UITableViewCell {
    
    // MARK: - PrivateProperties
    
    private var promotions: [PromotionCollectionViewCellViewModel] = []
    
    private lazy var collectionViewLayout = make(UICollectionViewFlowLayout()) { layout in
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(
            width: 300,
            height: 112
        )
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
    }
    
    private lazy var collectionView = make(UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout
    )) { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.customRegister(PromotionCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
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
    
    func configureCell(with viewModel: PromotionsTableViewCellViewModel) {
        promotions = viewModel.promotions
        collectionView.reloadData()
    }
}

// MARK: - PrivateMethods

private extension PromotionsTableViewCell {
    func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        contentView.addSubviews(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 112)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension PromotionsTableViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return promotions.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel = promotions[indexPath.item]
        let cell = collectionView.customDequeueReusableCell(
            PromotionCollectionViewCell.self,
            indexPath: indexPath
        )
        cell.configureCell(with: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension PromotionsTableViewCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(#function)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PromotionsTableViewCell: UICollectionViewDelegateFlowLayout {}
