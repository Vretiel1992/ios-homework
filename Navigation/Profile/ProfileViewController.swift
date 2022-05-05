//
//  TasksViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 07.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthViewConstraint: NSLayoutConstraint?
    var heightViewConstraint: NSLayoutConstraint?
    
    var isExpanded = false
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    private lazy var backgroundView: UIView = {
        var backgroundView = UIView()
        backgroundView.alpha = 0
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.alpha = 0
        imageView.image = #imageLiteral(resourceName: "TimCook")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var closeButtonBigAvatarView: UIImageView = {
        let closeButton = UIImageView()
        closeButton.image = UIImage(systemName: "xmark.app.fill")
        closeButton.tintColor = .black
        closeButton.alpha = 0
        closeButton.isUserInteractionEnabled = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    var heightHeaderInSection: CGFloat = 170
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.setupConstraints()
        self.setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = ""
        self.navigationItem.backButtonTitle = "Назад"
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.closeButtonBigAvatarView)
        self.view.bringSubviewToFront(self.backgroundView)
        self.view.bringSubviewToFront(self.imageView)
        self.view.bringSubviewToFront(self.closeButtonBigAvatarView)
    }
    
    private func setupConstraints() {
        topConstraint = imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        leadingConstraint = imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        heightViewConstraint =  imageView.heightAnchor.constraint(equalToConstant: 100)
        widthViewConstraint =  imageView.widthAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.topConstraint,
            self.leadingConstraint,
            self.heightViewConstraint,
            self.widthViewConstraint,
            
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.closeButtonBigAvatarView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            self.closeButtonBigAvatarView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            self.closeButtonBigAvatarView.heightAnchor.constraint(equalToConstant: 40),
            self.closeButtonBigAvatarView.widthAnchor.constraint(equalToConstant: 40)
        ].compactMap({ $0 }))
    }
    
    private func setupGesture(){
        tapGestureRecognizer.addTarget(self, action: #selector(handleTapGesture(_:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer){
        guard tapGestureRecognizer === gestureRecognizer else { return }
        animationProfileImageView()
    }
    
    private func animationProfileImageView() {
        self.isExpanded.toggle()
        self.widthViewConstraint?.constant = self.isExpanded ? self.view.frame.width : 100
        self.heightViewConstraint?.constant = self.isExpanded ? self.view.frame.width : 100
        
        self.topConstraint?.constant = self.isExpanded ? (self.view.safeAreaLayoutGuide.layoutFrame.height - self.view.safeAreaLayoutGuide.layoutFrame.width) / 2 : 70
        self.leadingConstraint?.constant = self.isExpanded ? 0 : 20
        
        if isExpanded {
            closeButtonBigAvatarView.addGestureRecognizer(tapGestureRecognizer)
        } else {
            imageView.addGestureRecognizer(tapGestureRecognizer)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.imageView.layer.cornerRadius = self.isExpanded ? 0 : 50
            self.imageView.alpha = self.isExpanded ? 1 : 0
            self.backgroundView.alpha = self.isExpanded ? 0.7 : 0
            self.closeButtonBigAvatarView.alpha = self.isExpanded ? 1 : 0
            self.view.layoutIfNeeded()
        }
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        heightHeaderInSection = textFieldIsVisible ? 220 : 170
        
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.tableView.beginUpdates()
            self.view.layoutIfNeeded()
            self.tableView.endUpdates()
        } completion: { _ in
            completion()
        }
    }
    
    func resizeProfileImage() {
        animationProfileImageView()
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell",
                                                           for: indexPath) as? PhotosTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell",
                                                           for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let article = dataSource[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                        description: article.description,
                                                        image: article.image,
                                                        likes: article.likes,
                                                        views: article.views)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? ProfileHeaderView
        view?.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? heightHeaderInSection : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let PhotoVC = PhotosViewController()
            navigationController?.pushViewController(PhotoVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}


