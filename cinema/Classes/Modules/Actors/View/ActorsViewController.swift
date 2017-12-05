//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ActorsViewController: ParentViewController {

    var output: ActorsViewOutput!

    let name: String

    let role: String

    let contentView = UIView()

    let scrollView = UIScrollView()

    let persons: [PersonFromFilm]

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 160

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    init(name: String, role: String, persons: [PersonFromFilm]) {
        self.name = name
        self.role = role
        self.persons = persons
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        view.backgroundColor = .white

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        let homeButton = UIButton()
        homeButton.setImage(Asset.Cinema.home.image, for: .normal)
        homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
        homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        frame = homeButton.frame
        frame.origin.x -= 9
        frame.size = CGSize(width: 30, height: 100)
        homeButton.frame = frame
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)

        activityVC.isHidden = false
        activityVC.startAnimating()

        let titleView = UIView()
        titleView.heightAnchor ~= 88
        let titleViewLabel = UILabel()
        titleViewLabel.text = name
        titleViewLabel.lineBreakMode = .byTruncatingTail
        titleViewLabel.font = UIFont.cnmFutura(size: 20)
        titleViewLabel.textColor = UIColor.cnmGreyDark
        titleViewLabel.widthAnchor ~= windowWidth + 40
        titleViewLabel.textAlignment = .center
        titleView.addSubview(titleViewLabel.prepareForAutoLayout())
        titleViewLabel.centerXAnchor ~= titleView.centerXAnchor
        titleViewLabel.centerYAnchor ~= titleView.centerYAnchor - 7
        //titleViewLabel.topAnchor ~= titleView.topAnchor

        let titleLabel = UILabel()
        titleLabel.font = UIFont.cnmFuturaLight(size: 14)
        titleLabel.textColor = UIColor.cnmAfafaf
        titleLabel.text = role
        titleLabel.textAlignment = .center

        titleView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= titleView.centerXAnchor
        titleLabel.topAnchor ~= titleViewLabel.bottomAnchor

        setScrollView()

        navigationItem.titleView = titleView
    }

    func setScrollView() {
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        view.addSubview(separatorView.prepareForAutoLayout())
        separatorView.topAnchor ~= view.topAnchor + 64
        separatorView.leadingAnchor ~= view.leadingAnchor
        separatorView.trailingAnchor ~= view.trailingAnchor
        separatorView.heightAnchor ~= 10

        view.addSubview(scrollView.prepareForAutoLayout())
        scrollView.topAnchor ~= separatorView.bottomAnchor
        scrollView.leadingAnchor ~= view.leadingAnchor
        scrollView.trailingAnchor ~= view.trailingAnchor
        scrollView.bottomAnchor ~= view.bottomAnchor

        scrollView.addSubview(contentView.prepareForAutoLayout())
        contentView.pinEdgesToSuperviewEdges(top: 0, left: 0, right: 0, bottom: 10)
        contentView.widthAnchor ~= view.widthAnchor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backButtonTap()
    }

    func didTapHomeButton() {
        output?.homeButtonTap()
    }

    func setSubviews(person: FullPerson) {
        let actorHeaderView = ActorHeaderView(person: person)
        contentView.addSubview(actorHeaderView.prepareForAutoLayout())
        actorHeaderView.topAnchor ~= contentView.topAnchor
        actorHeaderView.leadingAnchor ~= contentView.leadingAnchor
        actorHeaderView.trailingAnchor ~= contentView.trailingAnchor

        let actorFilmsView = ActorFilmsView(films: person.films)
        contentView.addSubview(actorFilmsView.prepareForAutoLayout())
        actorFilmsView.topAnchor ~= actorHeaderView.bottomAnchor + 30
        actorFilmsView.leadingAnchor ~= contentView.leadingAnchor
        actorFilmsView.trailingAnchor ~= contentView.trailingAnchor
        actorFilmsView.delegate = self

        let rolesLabel = UILabel()
        rolesLabel.textColor = UIColor.cnm3a3a3a
        rolesLabel.text = L10n.personsActorsProducers
        rolesLabel.font = UIFont.cnmFuturaBold(size: 16)
        rolesLabel.textAlignment = .left

        contentView.addSubview(rolesLabel.prepareForAutoLayout())
        rolesLabel.topAnchor ~= actorFilmsView.bottomAnchor + 21
        rolesLabel.leadingAnchor ~= contentView.leadingAnchor + 41
        rolesLabel.leadingAnchor ~= contentView.trailingAnchor - 41

        let rolesCV = RolesCV()
        rolesCV.delegate = self
        rolesCV.persons = persons.filter({$0.id != person.id})
        contentView.addSubview(rolesCV.prepareForAutoLayout())
        rolesCV.topAnchor ~= rolesLabel.bottomAnchor + 14
        rolesCV.heightAnchor ~= 110
        rolesCV.leadingAnchor ~= contentView.leadingAnchor
        rolesCV.trailingAnchor ~= contentView.trailingAnchor
        rolesCV.bottomAnchor ~= contentView.bottomAnchor
    }
}

// MARK: - ActorsViewInput

extension ActorsViewController: ActorsViewInput {

    func setupInitialState() {

    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func getPersonInfo(person: FullPerson) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
        setSubviews(person: person)
    }
}

// MARK: - RolesCVDelegate

extension ActorsViewController: RolesCVDelegate {
    func openPersonID(_ personID: String, name: String, role: String) {
        output?.openPersonID(personID, name: name, role: role, persons: persons)
    }
}

// MARK: - ActorFilmsViewDelegate

extension ActorsViewController: ActorFilmsViewDelegate {
    func openFilmID(_ film: String, name: String){
        output?.openFilmID(film, name: name)
    }
}
