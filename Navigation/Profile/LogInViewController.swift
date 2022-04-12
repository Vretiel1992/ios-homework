//
//  LogInViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 31.03.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        let logoImage = UIImage(named: "logo")
        imageView.image = logoImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.cornerRadius = 10
        stackView.distribution = .fillEqually
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        let appMyColor = UIColor(named: "myColor")
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.indent(size: 10)
        textField.tintColor = appMyColor
        textField.placeholder = "введите email"
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let appMyColor = UIColor(named: "myColor")
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.indent(size: 10)
        textField.tintColor = appMyColor
        textField.placeholder = "введите пароль"
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var displayButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.copy(alpha: 1), for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.copy(alpha: 0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.copy(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "blue_pixel")?.copy(alpha: 0.8), for: .disabled)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        
        self.displayButton.addTarget(self,
                                     action: #selector(performDisplayVC(parameterSender:)),
                                     for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name:
                        UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name:
                        UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name:
                            UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name:
                            UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.logoImage)
        self.contentView.addSubview(self.textFieldStackView)
        self.contentView.addSubview(self.displayButton)
        self.textFieldStackView.addArrangedSubview(self.loginTextField)
        self.textFieldStackView.addArrangedSubview(self.passwordTextField)
        self.loginTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            
            self.logoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120),
            self.logoImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.logoImage.heightAnchor.constraint(equalToConstant: 100),
            self.logoImage.heightAnchor.constraint(equalTo: self.logoImage.widthAnchor, multiplier: 1.0),
            
            self.textFieldStackView.topAnchor.constraint(equalTo: self.logoImage.bottomAnchor, constant: 120),
            self.textFieldStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.textFieldStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.textFieldStackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.displayButton.topAnchor.constraint(equalTo: self.textFieldStackView.bottomAnchor, constant: 30),
            self.displayButton.leadingAnchor.constraint(equalTo: self.textFieldStackView.leadingAnchor),
            self.displayButton.trailingAnchor.constraint(equalTo: self.textFieldStackView.trailingAnchor),
            self.displayButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.displayButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func kbdShow(notification: NSNotification) {
        guard let keyboardFrameValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue) else { return }
        let keyboardFrame = self.view.convert(keyboardFrameValue.cgRectValue, from: nil)
        if UIDevice.current.orientation.isLandscape {
            scrollView.contentInset.bottom = keyboardFrame.size.height + 20
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        } else {
            scrollView.contentInset.bottom = keyboardFrame.size.height + 80
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
    
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc private func tap(gesture: UITapGestureRecognizer) {
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @objc func performDisplayVC(parameterSender: Any) {
        let profileViewController = ProfileViewController()
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        return true
    }
}

extension UITextField {
    func indent(size: CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX,
                                             y: self.frame.minY,
                                             width: size,
                                             height: self.frame.height))
        self.leftViewMode = .always
    }
}

extension UIImage {
    func copy(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

