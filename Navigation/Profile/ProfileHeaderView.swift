//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Антон Денисюк on 14.03.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var statusText: String = ""
    
    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        let profileImage = UIImage(named: "TimCook")
        imageView.image = profileImage
        imageView.frame = CGRect(x: 16, y: 16, width: 120, height: 120)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    private let showStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show status", for: .normal)
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tim Cook"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let signatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Waiting for something..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    private func setupView() {

        self.addSubview(myImageView)
        self.addSubview(showStatusButton)
        self.showStatusButton.addTarget(self,
                                      action: #selector(buttonPressed(parameterSender:)),
                                      for: .touchUpInside)
        self.addSubview(nameLabel)
        self.addSubview(signatureLabel)
        self.addSubview(statusTextField)
        self.statusTextField.addTarget(self,
                                         action: #selector(statusTextChanged(parameterSender:)),
                                         for: .editingChanged)
        setConstraints()
    }
    
    @objc func buttonPressed(parameterSender: Any) {
        print(signatureLabel.text ?? "Cтатус не задан")
    }
    
    @objc func statusTextChanged(parameterSender: Any) {
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.showStatusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.showStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.showStatusButton.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 16),
            self.showStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27),
            self.nameLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 16),
            
            self.signatureLabel.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -34),
            self.signatureLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 16),
            
            self.statusTextField.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 16),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.statusTextField.topAnchor.constraint(equalTo: signatureLabel.bottomAnchor, constant: 5),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

