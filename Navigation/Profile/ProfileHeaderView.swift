//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Антон Денисюк on 14.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private var statusText: String = "Установите статус..."
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        let profileImage = UIImage(named: "TimCook")
        imageView.image = profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 120, height: 120)
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить статус", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = CGFloat(4.0)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тим Кук"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Установите статус..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.clearButtonMode = .always
        textField.placeholder = "введите текст"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isHidden = true
        return textField
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint?
    
    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        self.addSubview(self.infoStackView)
        self.addSubview(self.setStatusButton)
        self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.avatarImageView)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        
        self.setStatusButton.addTarget(self,
                                       action: #selector(didTapStatusButton(parameterSender:)),
                                       for: .touchUpInside)
        
        self.statusTextField.addTarget(self,
                                       action: #selector(statusTextChanged(parameterSender:)),
                                       for: .editingChanged)
        setConstraints()
    }
    
    @objc func didTapStatusButton(parameterSender: Any) {
        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            statusTextField.delegate = self
            
            self.buttonTopConstraint?.isActive = false
            
            let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
            let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
            let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
            self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 20)
            
            NSLayoutConstraint.activate([
                topConstraint,
                leadingConstraint,
                trailingConstraint,
                heightTextFieldConstraint,
                self.buttonTopConstraint
            ].compactMap({ $0 }))
            
            self.setStatusButton.setTitle("Применить статус", for: .normal)
        } else {
            self.statusLabel.text = self.statusText
            self.statusTextField.text = nil
            
            self.buttonTopConstraint?.isActive = false
            
            self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20)
            
            NSLayoutConstraint.activate([
                self.buttonTopConstraint
            ].compactMap( { $0 }))
            
            self.statusTextField.removeFromSuperview()
            self.setStatusButton.setTitle("Изменить статус", for: .normal)
        }
        
        self.delegate?.didTapStatusButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
    
    @objc func statusTextChanged(parameterSender: Any) {
        self.statusText = "\(self.statusTextField.text!)"
    }
    
    private func setConstraints() {
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        
        self.buttonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 20)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingButtonConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            imageViewAspectRatio,
            self.buttonTopConstraint,
            leadingButtonConstraint,
            trailingButtonConstraint,
            bottomButtonConstraint,
            heightButtonConstraint
        ].compactMap({ $0 }))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.statusTextField.resignFirstResponder()
        return true
    }
}

