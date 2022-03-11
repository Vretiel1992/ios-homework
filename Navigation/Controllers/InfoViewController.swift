//
//  InfoViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 10.03.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let displayButtons: UIButton = {
        let button = UIButton()
        button.setTitle("Показать алерт", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGreen
        self.displayButtons.addTarget(self,
                                      action: #selector(performAlert(parameterSender:)),
                                      for: .touchUpInside)
        self.view.addSubview(displayButtons)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.displayButtons.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            self.displayButtons.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            self.displayButtons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            self.displayButtons.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc func performAlert(parameterSender: Any) {
        let alert = UIAlertController(title: "Внимание, что-то важное",
                                      message: "Какое-то сообщение всплывающего окна",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: { action in
            print("Нажата кнопка ОК")
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
            print("Нажата кнопка Отмена")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
