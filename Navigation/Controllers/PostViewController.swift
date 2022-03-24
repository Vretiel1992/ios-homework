//
//  PostViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 08.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        self.title = titlePost.title
        
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
