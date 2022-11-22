//
//  CategoriesHeaderView.swift
//  FoodDelivery
//
//  Created by Swift Learning on 21.10.2022.
//

import UIKit

final class CategoriesHeaderView: UITableViewHeaderFooterView {
    weak var delegate: CategoriesHeaderViewModelDelegate?
    
    // MARK: - PrivateProperties
    
    private var categories: [CategoryCellViewModel] = []
    
    private lazy var collectionViewLayout = make(UICollectionViewFlowLayout()) { layout in
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
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
        collectionView.customRegister(CategoryCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    // MARK: - Initializer
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureView(with viewModel: CategoriesHeaderViewModel) {
        categories = viewModel.categories
        collectionView.reloadData()
        self.delegate = viewModel.delegate
    }
    
    func scrollToItem(at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - PrivateMethods

private extension CategoriesHeaderView {
    func calculateCellWidth(at index: Int) -> CGFloat {
        let label = UILabel()
        label.text = categories[index].title
        label.sizeToFit()
        return label.frame.size.width + 32
    }
    
    func setupView() {
        backgroundColor = .clear
        addSubViews()
        setupConstraints()
    }
    
    func addSubViews() {
        contentView.addSubviews(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 24
            ),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -24
            ),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension CategoriesHeaderView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel = categories[indexPath.item]
        let cell = collectionView.customDequeueReusableCell(
            CategoryCollectionViewCell.self,
            indexPath: indexPath
        )
        cell.configureCell(with: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoriesHeaderView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.didTapCategory(at: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = calculateCellWidth(at: indexPath.item)
        return CGSize(width: width, height: 32)
    }
}
