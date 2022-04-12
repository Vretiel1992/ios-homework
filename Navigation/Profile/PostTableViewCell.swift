//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Антон Денисюк on 10.04.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let author, description, image: String
        var likes, views: Int
    }
    
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
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.setContentCompressionResistancePriority(UILayoutPriority(100), for: .vertical)
        return imageView
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var likesAndViewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.authorLabel.text = nil
        self.pictureView.image = nil
        self.descriptionLabel.text = nil
        self.likesLabel.text = nil
        self.viewsLabel.text = nil
    }
    
    private func setupView() {
        contentView.backgroundColor = .white
        contentView.addSubview(self.backView)
        self.backView.addSubview(self.postStackView)
        self.postStackView.addArrangedSubview(self.authorLabel)
        self.postStackView.addArrangedSubview(self.pictureView)
        self.postStackView.addArrangedSubview(self.descriptionLabel)
        self.postStackView.addArrangedSubview(self.likesAndViewsStackView)
        self.likesAndViewsStackView.addArrangedSubview(self.likesLabel)
        self.likesAndViewsStackView.addArrangedSubview(self.viewsLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        
          
            self.postStackView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16),
            self.postStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),
            self.postStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16),
            self.postStackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)
        ])
    }
}

extension PostTableViewCell: Setupable {
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.authorLabel.text = viewModel.author
        self.pictureView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likesLabel.text = "Likes: \(viewModel.likes)"
        self.viewsLabel.text = "Views: \(viewModel.views)"
    }
}
