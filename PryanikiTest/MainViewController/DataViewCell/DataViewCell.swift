//
//  DataViewCell.swift
//  PryanikiTest
//
//  Created by Alex Kulish on 27.05.2022.
//

import UIKit

class DataViewCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    var selectorHandler: ((_ index: Int) -> Void)?
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var selector: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(frame: CGRect.zero)
        segmentedControl.addTarget(self, action: #selector(selectedSegment(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.isHidden = true
        return segmentedControl
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLabelConstraints()
        setupImageConstraints()
        setupSelectorConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with dataBlock: DataBlock) {
        switch dataBlock.name {
        case "hz":
            titleLabel.text = dataBlock.data.text
            titleLabel.isHidden = false
        case "selector":
            let variants = dataBlock.data.variants
            variants?.forEach{ selector.insertSegment(withTitle: $0.text, at: $0.id, animated: false)}
            selector.selectedSegmentIndex = dataBlock.data.selectedId ?? 0
            selector.isHidden = false
        default:
            imageView.setImage(with: dataBlock.data.url ?? "")
            imageView.isHidden = false
        }
    }
    
    // MARK: Private methods
    
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(selector)
    }
    
    private func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupImageConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupSelectorConstrains() {
        NSLayoutConstraint.activate([
            selector.topAnchor.constraint(equalTo: topAnchor),
            selector.leadingAnchor.constraint(equalTo: leadingAnchor),
            selector.trailingAnchor.constraint(equalTo: trailingAnchor),
            selector.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func selectedSegment(_ sender: UISegmentedControl) {
        selectorHandler?(sender.selectedSegmentIndex)
    }
}
