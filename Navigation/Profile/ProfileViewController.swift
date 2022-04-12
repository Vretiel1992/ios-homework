//
//  TasksViewController.swift
//  Navigation
//
//  Created by Антон Денисюк on 07.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
        private lazy var profileHeaderView: ProfileHeaderView = {
            let view = ProfileHeaderView(frame: .zero)
            view.delegate = self
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private var heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupView()
        self.loadDataSource()
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(self.tap(gesture:)))
        self.view.addGestureRecognizer(tapGesture)

    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Профиль"
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.tableView)
//        self.tableView.addSubview(self.profileHeaderView)

        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 170)
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
//            self.profileHeaderView.topAnchor.constraint(equalTo: self.tableView.topAnchor),
//            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor),
//            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor),

            self.heightConstraint
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
            Post(author: "Тим Кук получил первое вознаграждение акциями за девять лет",
                 description: "Apple наградила своего гендиректора правом на получение 334 000 акций компании.\nЭто первое вознаграждение Тима Кука как главы Apple с 2011 года. Тогда он возглавил компанию и получил первый грант в размере 1 млн акций, передача которых растянута на 10 лет. Акции — это основное вознаграждение Кука, хотя он также получает зарплату и ежегодный бонус: в 2019-м $3 млн и $7,67 млн соответственно. Но с учетом полученной доли акций его общий доход за год превысил $125 млн.",
                 image: "005",
                 likes: 2218,
                 views: 2904))
        dataSource.append(
            Post(author: "1447 к 1: соотношение доходов главы Apple к ее штатному сотруднику",
                 description: "В августе рыночная стоимость Apple все еще приближалась к 2,5 триллионам долларов, а за прошедшее время она перешагнула отметку в 3 триллиона долларов. За последние пару лет сотрудники Apple, как никогда ранее, открыто заявили о проблемах внутренней культуры компании, включая стремление вернуться в офис и прозрачность заработной платы, а также многое другое.\nApple отмечает в собственном документе, что после сложения “базовой зарплаты, бонусов, комиссионных и справедливой стоимости на дату предоставления акций, предоставленных сотрудникам в 2021 году”, чтобы найти зарплату среднестатистического сотрудника, итоговая сумма получилась чуть больше 68 тыс долларов в год, что примерно в 1447 раз меньше зарплаты Кука.",
                 image: "006",
                 likes: 5744,
                 views: 6580))
    }
    
    @objc private func tap(gesture: UITapGestureRecognizer) {
        profileHeaderView.statusTextField.resignFirstResponder()
    }
    
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 220 : 170
        
        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        220
        
//        return self.heightConstraint?.constant == 220 ? 220 : 170

    }
}



