//
//  TasksViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 07.03.2022.
//

import UIKit

protocol ProfileImageIncreasable: AnyObject {
    func resizeProfileImage()
}

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
        imageView.image = UIImage(named: "TimCook")
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
    
    weak var delegate: ProfileImageIncreasable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.setupConstraints()
        self.loadDataSource()
        self.setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Профиль"
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
    
    private func loadDataSource() {
        dataSource.append(
            Post(author: "Тим Кук и Стив Джобс в 2010 году",
                 description: "Нет сомнений в том, что, работая вместе, эти двое мужчин сумели превратить Apple в гигантскую, утонченную и взвешенную компанию. Несмотря на этот прогресс, многие критики предсказывали смерть Apple и конец ее легенды смертью Стива Джобса в 2011 году, особенно после передачи руководства Apple Тиму Куку. Фактически, эта критика и эти опасения по поводу краха Apple все еще звучат по сей день, несмотря на то, что Apple является одной из самых мощных и прибыльных компаний в мире.",
                 image: "001",
                 likes: 2597,
                 views: 3643))
        dataSource.append(
            Post(author: "Тим Кук и его возможный преемник",
                 description: "За последние пару лет из компании ушли Джони Айв, Дэн Риччио и Фил Шиллер, занимавшие руководящие должности. Тим Кук работает в Apple с 1997 года, ему больше 60 лет.\nРанее в Bloomberg отмечали, что на смену Куку может прийти операционный директор Джефф Уильямс или глава по аппаратному обеспечению Джон Тернус.",
                 image: "002",
                 likes: 3404,
                 views: 5990))
        dataSource.append(
            Post(author: "Apple покупает новые компании каждые 3-4 недели",
                 description: "Apple не просто так считается самой инновационной компанией мира. Она развивает такие технологии, о которых многие из её конкурентов даже не помышляют. Другое дело, что далеко не всегда в основу новаторских проектов Apple ложатся её собственные наработки. Нет, в компании не занимаются воровством технологий, хотя время от времени её в этом обвиняют и даже пытаются что-то у неё отсудить. Apple просто находит малоизвестные стартапы с технологиями, которые кажутся ей перспективными, и просто покупает их. Примерно каждые 3-4 недели.",
                 image: "003",
                 likes: 904,
                 views: 1101))
        dataSource.append(
            Post(author: "Тим Кук с китайскими разработчиками софта",
                 description: "Тим Кук впервые открыл рынок Китая для Apple, когда в 2000 году перенес производство на местные заводы. Он использовал это производственное присутствие, создавшее более трех миллионов рабочих мест в цепочке поставок Apple, в качестве рычага для расширения продаж, подписав в 2014 году соглашение с China Mobile, которая увеличила продажи iPhone, приведя 700 миллионов новых пользователей. Сделка помогла превратить Китай во второй по величине рынок для Apple.",
                 image: "004",
                 likes: 677,
                 views: 883))
        dataSource.append(
            Post(author: "Тим Кук получил первое вознаграждение акциями за 9 лет",
                 description: "Apple наградила своего гендиректора правом на получение 334 000 акций компании.\nЭто первое вознаграждение Тима Кука как главы Apple с 2011 года. Тогда он возглавил компанию и получил первый грант в размере 1 млн акций, передача которых растянута на 10 лет. Акции — это основное вознаграждение Кука, хотя он также получает зарплату и ежегодный бонус: в 2019-м $3 млн и $7,67 млн соответственно. Но с учетом полученной доли акций его общий доход за год превысил $125 млн.",
                 image: "005",
                 likes: 2218,
                 views: 2904))
        dataSource.append(
            Post(author: "1447 к 1: соотношение доходов главы Apple к штатному сотруднику",
                 description: "В августе рыночная стоимость Apple все еще приближалась к 2,5 триллионам долларов, а за прошедшее время она перешагнула отметку в 3 триллиона долларов. За последние пару лет сотрудники Apple, как никогда ранее, открыто заявили о проблемах внутренней культуры компании, включая стремление вернуться в офис и прозрачность заработной платы, а также многое другое.\nApple отмечает в собственном документе, что после сложения “базовой зарплаты, бонусов, комиссионных и справедливой стоимости на дату предоставления акций, предоставленных сотрудникам в 2021 году”, чтобы найти зарплату среднестатистического сотрудника, итоговая сумма получилась чуть больше 68 тыс долларов в год, что примерно в 1447 раз меньше зарплаты Кука.",
                 image: "006",
                 likes: 5744,
                 views: 6580))
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
        self.tableView.beginUpdates()
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
        self.tableView.endUpdates()
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
        view?.delegate2 = self
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

extension ProfileViewController: ProfileImageIncreasable {
    func resizeProfileImage() {
        animationProfileImageView()
    }
}


