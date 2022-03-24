//
//  TasksViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 07.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Профиль"
        self.view.addSubview(profileHeaderView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = self.view.safeAreaLayoutGuide.layoutFrame
        profileHeaderView.backgroundColor = .lightGray
    }
}

