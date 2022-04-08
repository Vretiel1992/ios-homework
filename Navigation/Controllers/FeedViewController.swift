//
//  ScheduleViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 07.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    private lazy var displayButton1: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var displayButton2: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var centerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.title = "Лента"
        self.navigationItem.backButtonTitle = ""
        self.view.addSubview(self.centerStackView)
        self.view.addSubview(self.displayButton1)
        self.view.addSubview(self.displayButton2)
        self.centerStackView.addArrangedSubview(displayButton1)
        self.centerStackView.addArrangedSubview(displayButton2)
        self.displayButton1.addTarget(self,
                                      action: #selector(performDisplayVC(parameterSender:)),
                                      for: .touchUpInside)
        self.displayButton2.addTarget(self,
                                      action: #selector(performDisplayVC(parameterSender:)),
                                      for: .touchUpInside)
    }
    
    @objc func performDisplayVC(parameterSender: Any) {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.centerStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            self.centerStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            self.centerStackView.heightAnchor.constraint(equalToConstant: 110),
            self.centerStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.centerStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}

