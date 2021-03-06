//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class FilmViewController: ParentViewController {

    var output: FilmViewOutput!
    var filmInformation: FullFilm?
    var name: String = ""

    var myRate: Int = 0

    let contentView = UIView()
    let imageView = UIImageView()
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

    let starsLabel = UILabel()

    let starsView = UIView()

    var starsButons: [StarView] = []

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

        activityVC.isHidden = false
        activityVC.startAnimating()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        titleViewLabel.text = name
        titleViewLabel.font = UIFont.cnmFutura(size: 20)

        starsLabel.text = L10n.filmYourStar

        watchedButton.addTarget(self, action: #selector(didTapWatchedButton), for: .touchUpInside)

        willWatchButton.addTarget(self, action: #selector(didTapWillWatchButton), for: .touchUpInside)

        for i in 0...9 {
            let starView = StarView()
            starView.setTagView(i)
            starView.button.addTarget(self, action: #selector(didTapStarButton), for: .touchUpInside)
            starsButons.append(starView)
        }

    }

    func setInfo() {
        if let filmInfo = filmInformation {

            myRate = filmInfo.myRate

            starsLabel.isHidden = true
            starsView.isHidden = true

            if filmInfo.iWatched {
                watchedButton.isSelected = true
                starsLabel.isHidden = false
                starsView.isHidden = false
                setStars(myRate)
            }

            if  filmInfo.iWillWatch {
                willWatchButton.isSelected = true
            }

            let titleLabel = UILabel()
            titleLabel.font = UIFont.cnmFuturaLight(size: 14)
            titleLabel.textColor = UIColor.cnmAfafaf
            var textsArray: [String] = []
            for genres in filmInfo.genres {
                if let text = genres.name, !text.isEmpty {
                    textsArray.append(text.capitalized)
                }
            }
            titleLabel.text = textsArray.joined(separator: "/") + " (" + String(filmInfo.yearFirstRelease) + ")"
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
            contentView.widthAnchor ~= view.widthAnchor
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false

            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: filmInfo.imageUrl))

            contentView.addSubview(imageView.prepareForAutoLayout())
            imageView.topAnchor ~= contentView.topAnchor + 11
            imageView.centerXAnchor ~= contentView.centerXAnchor
            imageView.widthAnchor ~= windowWidth
            imageView.heightAnchor ~= windowWidth / 3 * 4
            imageView.layer.cornerRadius = 5.0
            imageView.layer.masksToBounds = true

            let chatButton = UIButton()
            chatButton.setImage(Asset.Cinema.chatIcon.image, for: .normal)
            contentView.addSubview(chatButton.prepareForAutoLayout())
            chatButton.leadingAnchor ~= imageView.trailingAnchor + 26
            chatButton.topAnchor ~= imageView.topAnchor + 20

            chatButton.addTarget(self, action: #selector(didTapChatButton), for: .touchUpInside)

            let sharingButton = UIButton()
            sharingButton.setImage(Asset.Cinema.sharing.image, for: .normal)
            contentView.addSubview(sharingButton.prepareForAutoLayout())
            sharingButton.leadingAnchor ~= imageView.trailingAnchor + 26
            sharingButton.topAnchor ~= chatButton.bottomAnchor + 9

            sharingButton.addTarget(self, action: #selector(didTapSharingButton), for: .touchUpInside)

            let buttonsStack = createStackView(.horizontal, .fill, .fill, 1, with: [watchedButton, UIView().separator(), willWatchButton])

            starsLabel.font = UIFont.cnmFuturaLight(size: 16)
            starsLabel.textColor = UIColor.cnmAfafaf
            starsLabel.textAlignment = .center

            let starsStack = createStackView(.horizontal, .fill, .fill, 8, with: starsButons)
            starsView.addSubview(starsStack.prepareForAutoLayout())
            starsStack.heightAnchor ~= 35
            starsStack.topAnchor ~= starsView.topAnchor
            starsStack.bottomAnchor ~= starsView.bottomAnchor
            starsStack.centerXAnchor ~= starsView.centerXAnchor

            let willStack = createStackView(.vertical, .fill, .fill, 20.0, with: [buttonsStack, starsLabel, starsView])
            contentView.addSubview(willStack.prepareForAutoLayout())
            willStack.topAnchor ~= imageView.bottomAnchor + 26
            willStack.leadingAnchor ~= contentView.leadingAnchor
            willStack.trailingAnchor ~= contentView.trailingAnchor

            contentView.addSubview(buyButton.prepareForAutoLayout())
            buyButton.topAnchor ~= willStack.bottomAnchor + 36
            buyButton.centerXAnchor ~= contentView.centerXAnchor

            contentView.addSubview(inviteButton.prepareForAutoLayout())
            inviteButton.topAnchor ~= buyButton.bottomAnchor + 15
            inviteButton.centerXAnchor ~= contentView.centerXAnchor

            let infoStack = createStackView(.horizontal, .fill, .fill, 0, with: [
                UIView().setParameters(
                    topLabelText: filmInfo.rateTmdb == 0 ? " " : String(filmInfo.rateTmdb),
                    bottomLabelText: L10n.filmTmdbText),
                UIView().setParameters(
                    topLabelText: filmInfo.duration == 0 ? " " : String(filmInfo.duration) + " мин",
                    bottomLabelText: L10n.filmDurationText),
                UIView().setParameters(
                    topLabelText: filmInfo.ageLimit == nil ? " " : String(format: "%@ +", (filmInfo.ageLimit)!),
                    bottomLabelText: L10n.filmAgeText)
                ])
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
        textView.attributedReadMoreText = NSAttributedString(string: L10n.filmMoreButton, attributes: [
            NSForegroundColorAttributeName: UIColor.cnmBlueLight,
            NSFontAttributeName: UIFont.cnmFutura(size: 14)
            ])

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
        rolesCV.heightAnchor ~= 110
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
            UIView().setParameters2(topLabelText: filmInfo.budget > 0 ?
                String(filmInfo.budget).setPriceMask() + " $" :
                " ", bottomLabelText: L10n.filmBudjetText), UIView().separator(),
            UIView().setParameters2(topLabelText: filmInfo.gross > 0
                ? String(filmInfo.gross).setPriceMask() + " $"
                : " ", bottomLabelText: L10n.filmCashText)])
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
        starsLabel.isHidden = !watchedButton.isSelected
        starsView.isHidden = !watchedButton.isSelected
        willWatchButton.isSelected = false

        if !watchedButton.isSelected {
            activityVC.isHidden = false
            activityVC.startAnimating()
            output.watchedTapDelete()
        } else {
            showAlert(message: L10n.filmWatchAlert)
            setStars(0)
        }
    }

    func didTapWillWatchButton() {

        activityVC.isHidden = false
        activityVC.startAnimating()
        view.bringSubview(toFront: activityVC)

        willWatchButton.isSelected = !willWatchButton.isSelected
        starsLabel.isHidden = true
        starsView.isHidden = true
        watchedButton.isSelected = false

        if willWatchButton.isSelected {
            output.willWatchTap()
        } else {
            output.willWatchTapDelete()
        }

    }

    func didTapStarButton(button: UIButton) {
        setStars(button.tag + 1)
        output.watchedTap(rate: button.tag + 1)
        activityVC.isHidden = false
        activityVC.startAnimating()
    }

    func didTapChatButton() {
        print()
    }

    func didTapSharingButton() {
        let textToShare = "CinemaD"

        if let image = imageView.image {
            let objectsToShare = [textToShare, image] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

            //activityVC.popoverPresentationController?.sourceView = sender
            present(activityVC, animated: true, completion: nil)
        }
    }

    func setStars(_ tag: Int) {
        myRate = tag

            for starView in starsButons {

                if tag == 0 {
                    starView.setState(false, labelIsHidden: true)
                    continue
                }

                if starView.button.tag <= tag - 1 {
                    starView.setState(true, labelIsHidden: starView.button.tag != tag - 1)
                } else {
                    starView.setState(false, labelIsHidden: true)
                }
            }
    }
}

// MARK: - FilmViewInput

extension FilmViewController: FilmViewInput {

    func setupInitialState() {

    }

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setFilmInfo(_ filmInfo: FullFilm) {
        self.filmInformation = filmInfo
        activityVC.isHidden = true
        activityVC.stopAnimating()
        activityVC.color = UIColor.cnmMainOrange
        setInfo()
    }

    func statusChange() {
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }

    func setStatus(_ rate: Double) {
        activityVC.isHidden = true
        activityVC.stopAnimating()
    }
}

//private extension UIButton {
//    func setProperty() -> UIButton {
//        self.setImage(Asset.Cinema.unselectStar.image, for: .normal)
//        self.setImage(Asset.Cinema.selectStar.image, for: .selected)
//        self.widthAnchor ~= 19
//        self.heightAnchor ~= 17
//        return self
//    }
//}

private extension UIView {
    func separator() -> UIView {
        self.heightAnchor ~= 33
        self.widthAnchor ~= 1
        self.backgroundColor = UIColor.cnmAfafaf
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

extension String {
    func setPriceMask() -> String {
        var resultString = String()
        self.enumerated().forEach { index, character in

            // Add space every 4 characters

            if (self.count - index) % 3 == 0 && index > 0 {
                resultString += " "
            }
            resultString.append(character)
        }
        return resultString
    }
}
