//
//  ScheduleViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 07.03.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    private let displayButtons: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти на пост", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Лента"
        self.navigationItem.backButtonTitle = ""
        self.displayButtons.addTarget(self,
                                      action: #selector(performDisplayVC(parameterSender:)),
                                      for: .touchUpInside)
        self.view.addSubview(self.displayButtons)
        setConstraints()
    }
    
    @objc func performDisplayVC(parameterSender: Any) {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.displayButtons.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            self.displayButtons.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            self.displayButtons.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.displayButtons.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

