//
//  PostViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 08.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Unknown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemYellow
        self.navigationItem.title = titlePost
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(performDisplayVC(parameterSender:)))
    }
    
    @objc func performDisplayVC(parameterSender: Any) {
        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)
    }
}
