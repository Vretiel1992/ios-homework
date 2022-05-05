//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Антон Денисюк on 21.04.2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMinXMinYCorner,
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Фотографии"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "arrow.right")
        imageView.image = image
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pictureViewOne: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "01")
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pictureViewTwo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "02")
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pictureViewThree: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "03")
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var pictureViewFour: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "18")
        imageView.image = image
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imagesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubview(self.backView)
        
        self.backView.addSubview(photoLabel)
        self.backView.addSubview(arrowImageView)
        self.backView.addSubview(imagesStackView)
        self.imagesStackView.addArrangedSubview(pictureViewOne)
        self.imagesStackView.addArrangedSubview(pictureViewTwo)
        self.imagesStackView.addArrangedSubview(pictureViewThree)
        self.imagesStackView.addArrangedSubview(pictureViewFour)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            self.photoLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12),
            self.photoLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 12),
            
            self.arrowImageView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -12),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.photoLabel.centerYAnchor),
            self.arrowImageView.heightAnchor.constraint(equalTo: self.photoLabel.heightAnchor),
            self.arrowImageView.widthAnchor.constraint(equalTo: self.arrowImageView.heightAnchor, multiplier: 1.0),
        
            self.imagesStackView.topAnchor.constraint(equalTo: self.photoLabel.bottomAnchor, constant: 12),
            self.imagesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            self.imagesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            self.imagesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            self.imagesStackView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 48) / 4)
        ])
    }
}
