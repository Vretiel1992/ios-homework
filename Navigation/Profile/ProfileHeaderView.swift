//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Антон Денисюк on 14.03.2022.
//

import UIKit

class ProfileHeaderView: UIView, UITextFieldDelegate {
    
    private var statusText: String = "Waiting for something..."
    
    private lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        let profileImage = UIImage(named: "TimCook")
        imageView.image = profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 16, y: 16, width: 120, height: 120)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var showStatusButton: UIButton = {
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tim Cook"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var signatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Waiting for something..."
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
        textField.placeholder = "enter text"
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isHidden = true
        return textField
    }()
    
    var buttonTopConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupView() {
        
        self.addSubview(myImageView)
        self.addSubview(showStatusButton)
        self.showStatusButton.addTarget(self,
                                        action: #selector(buttonPressed(parameterSender:)),
                                        for: .touchUpInside)
        self.addSubview(nameLabel)
        self.addSubview(signatureLabel)
        self.statusTextField.addTarget(self,
                                       action: #selector(statusTextChanged(parameterSender:)),
                                       for: .editingChanged)
        setConstraints()
    }
    
    @objc func buttonPressed(parameterSender: Any) {
            if self.statusTextField.isHidden {
                self.addSubview(self.statusTextField)
                statusTextField.delegate = self
                
                let leadingStatusTextFieldConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.signatureLabel.leadingAnchor)
                let trailingStatusTextFieldConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
                let topStatusTextFieldConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.signatureLabel.bottomAnchor, constant: 5)
                let heighStatusTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
                
                self.buttonTopConstraint?.isActive = false
                self.buttonTopConstraint = self.showStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 10)
                
                NSLayoutConstraint.activate([
                    leadingStatusTextFieldConstraint,
                    trailingStatusTextFieldConstraint,
                    topStatusTextFieldConstraint,
                    heighStatusTextFieldConstraint,
                    self.buttonTopConstraint
                ].compactMap( { $0 }))
                
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                } completion: { _ in
                    self.statusTextField.isHidden = false
                }
                
                self.showStatusButton.setTitle("Set status", for: .normal)
            } else {
                self.signatureLabel.text = self.statusText
                self.statusTextField.text = nil
                self.buttonTopConstraint?.isActive = false
                self.buttonTopConstraint = self.showStatusButton.topAnchor.constraint(equalTo: self.signatureLabel.bottomAnchor, constant: 34)
                
                NSLayoutConstraint.activate([
                    self.buttonTopConstraint
                ].compactMap( { $0 }))
                
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                } completion: { _ in
                    self.statusTextField.isHidden = true
                }
                self.statusTextField.removeFromSuperview()
                
                self.showStatusButton.setTitle("Show status", for: .normal)
            }
    }
    
    @objc func statusTextChanged(parameterSender: Any) {
        self.statusText = "\(self.statusTextField.text!)"
    }
    
    private func setConstraints() {
        let leadingMyImageViewConstraint = self.myImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let topMyImageViewConstraint = self.myImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16)
        let heightMyImageViewConstraint = self.myImageView.heightAnchor.constraint(equalToConstant: 120)
        let widthMyImageViewConstraint = self.myImageView.widthAnchor.constraint(equalToConstant: 120)
        
        let topNameLabelConstraint = self.nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 27)
        let leadingNameLabelConstraint = self.nameLabel.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 16)
        
        let bottomSignatureLabelConstraint = self.signatureLabel.bottomAnchor.constraint(equalTo: self.myImageView.bottomAnchor, constant: -16)
        let leadingSignatureLabelConstraint = self.signatureLabel.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 16)
        
        self.buttonTopConstraint = self.showStatusButton.topAnchor.constraint(equalTo: self.signatureLabel.bottomAnchor, constant: 34)
        self.buttonTopConstraint?.priority = UILayoutPriority(rawValue: 999)
        let leadingShowStatusButtonConstraint = self.showStatusButton.leadingAnchor.constraint(equalTo: self.myImageView.leadingAnchor)
        let trailingShowStatusButtonConstraint = self.showStatusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let heightShowStatusButtonConstraint = self.showStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            leadingMyImageViewConstraint,
            topMyImageViewConstraint,
            heightMyImageViewConstraint,
            widthMyImageViewConstraint,
            self.buttonTopConstraint,
            leadingShowStatusButtonConstraint,
            trailingShowStatusButtonConstraint,
            heightShowStatusButtonConstraint,
            topNameLabelConstraint,
            leadingNameLabelConstraint,
            bottomSignatureLabelConstraint,
            leadingSignatureLabelConstraint
        ].compactMap( { $0 }))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.statusTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.statusTextField.resignFirstResponder()
        return true
    }
}

