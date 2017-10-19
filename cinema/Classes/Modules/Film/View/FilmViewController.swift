//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class FilmViewController: ParentViewController {

    var output: FilmViewOutput!
    var filmInformation: FullFilm?
    var name: String = ""

    let contentView = UIView()

    let scrollView = UIScrollView()

    let willWatchButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.filmWillWatchButton, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let desriptionLabel = UILabel()

    let watchedButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.filmWatchedButton, for: .normal)
        button.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        button.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        button.heightAnchor ~= 33
        button.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return button
    }()

    let separatorView: UIView = {
        let view = UIView()
        view.heightAnchor ~= 33
        view.widthAnchor ~= 1
        view.backgroundColor = UIColor.cnmAfafaf
        return view
    }()

    let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.filmPayTicket, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.cnmFutura(size: 16)
        button.backgroundColor = UIColor.cnmMainOrange
        button.layer.cornerRadius = 5.0
        button.heightAnchor ~= 53
        button.widthAnchor ~= 182
        return button
    }()

    let inviteButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.filmInviteFilm, for: .normal)
        button.setTitleColor(UIColor.cnmMainOrange, for: .normal)
        button.titleLabel?.font = UIFont.cnmFutura(size: 16)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.cnmMainOrange.cgColor
        button.layer.borderWidth = 1.0
        button.heightAnchor ~= 53
        button.widthAnchor ~= 182
        return button
    }()

    var starsButons: [UIButton] = []

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 160

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = name
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        watchedButton.addTarget(self, action: #selector(didTapWatchedButton), for: .touchUpInside)

        willWatchButton.addTarget(self, action: #selector(didTapWillWatchButton), for: .touchUpInside)

        for i in 0...9 {
            let button = UIButton().setProperty()
            button.tag = i
            button.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
            starsButons.append(button)
        }

    }

    func setInfo() {
        if let filmInfo = filmInformation {
            let titleLabel = UILabel()
            titleLabel.font = UIFont.cnmFuturaLight(size: 14)
            titleLabel.textColor = UIColor.cnmAfafaf
            var textsArray: [String] = []
            for genres in filmInfo.genres {
                if let text = genres.name {
                    textsArray.append(text)
                }
            }
            titleLabel.text = textsArray.joined(separator: "/") + "(" + String(filmInfo.yearFirstRelease) + ")"
            view.addSubview(titleLabel.prepareForAutoLayout())
            titleLabel.centerXAnchor ~= view.centerXAnchor
            titleLabel.topAnchor ~= titleViewLabel.bottomAnchor

            view.addSubview(scrollView.prepareForAutoLayout())
            scrollView.topAnchor ~= titleLabel.bottomAnchor + 10
            scrollView.leadingAnchor ~= view.leadingAnchor
            scrollView.trailingAnchor ~= view.trailingAnchor
            scrollView.bottomAnchor ~= view.bottomAnchor

            scrollView.addSubview(contentView.prepareForAutoLayout())
            contentView.pinEdgesToSuperviewEdges(top: 0, left: 0, right: 0, bottom: 10)
//            contentView.frame = CGRect(x: 0, y: 0, width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: 1_700)
//            scrollView.contentSize = CGSize(width: UIWindow(frame: UIScreen.main.bounds).bounds.width, height: 1_700)
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false

            let imageView = UIImageView()
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: filmInfo.imageUrl))

            contentView.addSubview(imageView.prepareForAutoLayout())
            imageView.topAnchor ~= contentView.topAnchor + 11
            imageView.centerXAnchor ~= contentView.centerXAnchor
            imageView.widthAnchor ~= windowWidth
            imageView.heightAnchor ~= windowWidth / 3 * 4

            let playButton = UIImageView(image: Asset.Cinema.play.image)
            imageView.addSubview(playButton.prepareForAutoLayout())
            playButton.centerXAnchor ~= imageView.centerXAnchor
            playButton.centerYAnchor ~= imageView.centerYAnchor
            playButton.heightAnchor ~= 51
            playButton.widthAnchor ~= 51

            let buttonsStack = createStackView(.horizontal, .fill, .fill, 1, with: [watchedButton, separatorView, willWatchButton])
            contentView.addSubview(buttonsStack.prepareForAutoLayout())
            buttonsStack.heightAnchor ~= 33
            buttonsStack.topAnchor ~= imageView.bottomAnchor + 26
            buttonsStack.leadingAnchor ~= contentView.leadingAnchor
            buttonsStack.trailingAnchor ~= contentView.trailingAnchor

            let starsLabel = UILabel()
            starsLabel.font = UIFont.cnmFuturaLight(size: 16)
            starsLabel.textColor = UIColor.cnmAfafaf
            starsLabel.text = L10n.filmYourStar
            contentView.addSubview(starsLabel.prepareForAutoLayout())
            starsLabel.centerXAnchor ~= contentView.centerXAnchor
            starsLabel.topAnchor ~= buttonsStack.bottomAnchor + 28

            let starsStack = createStackView(.horizontal, .fill, .fill, 8, with: starsButons)
            contentView.addSubview(starsStack.prepareForAutoLayout())
            starsStack.heightAnchor ~= 17
            starsStack.topAnchor ~= starsLabel.bottomAnchor + 20
            starsStack.centerXAnchor ~= contentView.centerXAnchor

            contentView.addSubview(buyButton.prepareForAutoLayout())
            buyButton.topAnchor ~= starsStack.bottomAnchor + 36
            buyButton.centerXAnchor ~= contentView.centerXAnchor

            contentView.addSubview(inviteButton.prepareForAutoLayout())
            inviteButton.topAnchor ~= buyButton.bottomAnchor + 15
            inviteButton.centerXAnchor ~= contentView.centerXAnchor

            let infoStack = createStackView(.horizontal, .fill, .fill, 0, with: [
                UIView().setParameters(topLabelText: String(filmInfo.rateTmdb), bottomLabelText: L10n.filmTmdbText),
                                                 UIView().setParameters(topLabelText: String(filmInfo.duration) + "мин", bottomLabelText: L10n.filmDurationText), UIView().setParameters(topLabelText: "0+", bottomLabelText: L10n.filmAgeText)])
            contentView.addSubview(infoStack.prepareForAutoLayout())
            infoStack.heightAnchor ~= 50
            infoStack.topAnchor ~= inviteButton.bottomAnchor + 35
            infoStack.centerXAnchor ~= contentView.centerXAnchor


            desriptionLabel.textColor = UIColor.cnm3a3a3a
            desriptionLabel.text = L10n.filmDescriptionText
            desriptionLabel.font = UIFont.cnmFuturaBold(size: 16)

            contentView.addSubview(desriptionLabel.prepareForAutoLayout())
            desriptionLabel.topAnchor ~= infoStack.bottomAnchor + 40
            desriptionLabel.leadingAnchor ~= contentView.leadingAnchor + 39

            setInfo2(filmInfo)
        }
    }

    func setInfo2(_ filmInfo: FullFilm) {
        let textView = ReadMoreTextView()

        textView.text = filmInfo.description

        textView.font = UIFont.cnmFutura(size: 14)
        textView.textColor = UIColor.cnmGreyLight
        textView.textAlignment = .justified
        textView.shouldTrim = true
        textView.maximumNumberOfLines = 4
        textView.attributedReadMoreText = NSAttributedString(string: L10n.filmMoreButton)

        contentView.addSubview(textView.prepareForAutoLayout())
        textView.topAnchor ~= desriptionLabel.bottomAnchor + 12
        textView.leadingAnchor ~= contentView.leadingAnchor + 40
        textView.trailingAnchor ~= contentView.trailingAnchor - 40

        let rolesLabel = UILabel()
        rolesLabel.textColor = UIColor.cnm3a3a3a
        rolesLabel.text = L10n.filmMansText
        rolesLabel.font = UIFont.cnmFuturaBold(size: 16)

        contentView.addSubview(rolesLabel.prepareForAutoLayout())
        rolesLabel.topAnchor ~= textView.bottomAnchor + 29
        rolesLabel.leadingAnchor ~= contentView.leadingAnchor + 39

        let rolesCV = RolesCV()
        rolesCV.persons = filmInfo.persons
        contentView.addSubview(rolesCV.prepareForAutoLayout())
        rolesCV.topAnchor ~= rolesLabel.bottomAnchor + 14
        rolesCV.heightAnchor ~= 150
        rolesCV.leadingAnchor ~= contentView.leadingAnchor
        rolesCV.trailingAnchor ~= contentView.trailingAnchor

        let sepView = UIView()
        sepView.backgroundColor = UIColor.cnmAfafaf
        contentView.addSubview(sepView.prepareForAutoLayout())
        sepView.topAnchor ~= rolesCV.bottomAnchor + 10
        sepView.leadingAnchor ~= contentView.leadingAnchor + 25
        sepView.trailingAnchor ~= contentView.trailingAnchor - 25
        sepView.heightAnchor ~= 1

        let infoStack = createStackView(.horizontal, .fill, .fill, 1, with: [
            UIView().setParameters2(topLabelText: "11700000 " + "$", bottomLabelText: L10n.filmBudjetText), separatorView,
            UIView().setParameters2(topLabelText: "5600000 " + "$", bottomLabelText: L10n.filmCashText)])
        contentView.addSubview(infoStack.prepareForAutoLayout())
        infoStack.heightAnchor ~= 50
        infoStack.topAnchor ~= sepView.bottomAnchor + 10
        infoStack.leadingAnchor ~= contentView.leadingAnchor
        infoStack.trailingAnchor ~= contentView.trailingAnchor
        infoStack.bottomAnchor ~= contentView.bottomAnchor
    }

    // MARK: - Actions
    func didTapLeftButton() {
        output?.backTap()
    }

    func didTapWatchedButton() {
        watchedButton.isSelected = !watchedButton.isSelected
        willWatchButton.isSelected = false
    }

    func didTapWillWatchButton() {
        willWatchButton.isSelected = !willWatchButton.isSelected
        watchedButton.isSelected = false
    }

    func didTapStarButton(button: UIButton) {
        for buttonStar in starsButons {
            if buttonStar.tag <= button.tag {
                buttonStar.isSelected = true
            } else {
                buttonStar.isSelected = false
            }
        }
    }
}

// MARK: - FilmViewInput

extension FilmViewController: FilmViewInput {

    func setupInitialState() {

    }

    func setFilmInfo(_ filmInfo: FullFilm) {
        self.filmInformation = filmInfo
        setInfo()
    }
}

private extension UIButton {
    func setProperty() -> UIButton {
        self.setImage(Asset.Cinema.unselectStar.image, for: .normal)
        self.setImage(Asset.Cinema.selectStar.image, for: .selected)
        self.widthAnchor ~= 19
        self.heightAnchor ~= 17
        return self
    }
}

private extension UIView {
    func setParameters(topLabelText: String, bottomLabelText: String) -> UIView {

        let topLabel = UILabel()
        topLabel.text = topLabelText
        topLabel.font = UIFont.cnmFutura(size: 17)
        topLabel.textColor = UIColor.cnmMainOrange
        self.addSubview(topLabel.prepareForAutoLayout())
        topLabel.topAnchor ~= self.topAnchor
        topLabel.centerXAnchor ~= self.centerXAnchor

        let bottomLabel = UILabel()
        bottomLabel.text = bottomLabelText
        bottomLabel.font = UIFont.cnmFutura(size: 13)
        bottomLabel.textColor = UIColor.cnmAfafaf
        self.addSubview(bottomLabel.prepareForAutoLayout())
        bottomLabel.topAnchor ~= topLabel.bottomAnchor + 8
        bottomLabel.centerXAnchor ~= self.centerXAnchor
        bottomLabel.bottomAnchor ~= self.bottomAnchor

        self.widthAnchor ~= UIWindow(frame: UIScreen.main.bounds).bounds.width / 3

        return self
    }

    func setParameters2(topLabelText: String, bottomLabelText: String) -> UIView {

        let topLabel = UILabel()
        topLabel.text = topLabelText
        topLabel.font = UIFont.cnmFutura(size: 16)
        topLabel.textColor = UIColor.cnmMainOrange
        self.addSubview(topLabel.prepareForAutoLayout())
        topLabel.topAnchor ~= self.topAnchor
        topLabel.centerXAnchor ~= self.centerXAnchor

        let bottomLabel = UILabel()
        bottomLabel.text = bottomLabelText
        bottomLabel.font = UIFont.cnmFutura(size: 13)
        bottomLabel.textColor = UIColor.cnmAfafaf
        self.addSubview(bottomLabel.prepareForAutoLayout())
        bottomLabel.topAnchor ~= topLabel.bottomAnchor + 8
        bottomLabel.centerXAnchor ~= self.centerXAnchor
        bottomLabel.bottomAnchor ~= self.bottomAnchor

        self.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2

        return self
    }
}
