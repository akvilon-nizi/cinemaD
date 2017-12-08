//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import FacebookShare
import FBSDKShareKit
import VKSdkFramework
import YouTubeiOSPlayerHelper

class FilmViewController: ParentViewController {

    var output: FilmViewOutput!
    var filmInformation: FullFilm?
    var name: String = ""

    var myRate: Int = 0

    var genres: String = ""

    var videoID: String = ""

    fileprivate let playButton = UIButton()

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

    let textView = ReadMoreTextView()

    let desriptionLabel = UILabel()

    var descriptions: String = ""

    let titleLabel = UILabel()

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    fileprivate let youtubeView = YTPlayerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        let sdk = VKSdk.initialize(withAppId: "6258240")
        sdk?.register(self)
        //sdk.ui

        activityVC.isHidden = false
        activityVC.startAnimating()

        let backButton = UIButton()
        backButton.setImage(Asset.NavBar.navBarArrowBack.image, for: .normal)
        backButton.addTarget(self, action: #selector(didTapLeftButton), for: .touchUpInside)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //backButton.contentMode = .center
        var frame = backButton.frame
        frame.size = CGSize(width: 30, height: 100)
        backButton.frame = frame
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        if let navCont = navigationController, navCont.viewControllers.count > 2 {
            let homeButton = UIButton()
            homeButton.setImage(Asset.Cinema.home.image, for: .normal)
            homeButton.addTarget(self, action: #selector(didTapHomeButton), for: .touchUpInside)
            homeButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            frame = homeButton.frame
            frame.origin.x -= 9
            frame.size = CGSize(width: 30, height: 100)
            homeButton.frame = frame
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: homeButton)
        }

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

        titleLabel.font = UIFont.cnmFuturaLight(size: 14)
        titleLabel.textColor = UIColor.cnmAfafaf

        titleView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= titleView.centerXAnchor
        titleLabel.topAnchor ~= titleViewLabel.bottomAnchor 

        navigationItem.titleView = titleView

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

    func loadYT(videoID: String) {
        youtubeView.load(withVideoId: videoID, playerVars: [
            "playsinline": 1,
            "disablekb": 1,
            "iv_load_policy": 3,
            "rel": 0,
            "modestbranding": 1
            ])
        youtubeView.webView?.allowsInlineMediaPlayback = false
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

            var textsArray: [String] = []
            for genres in filmInfo.genres {
                if let text = genres.name, !text.isEmpty {
                    textsArray.append(text.capitalized)
                }
            }

            genres = textsArray.joined(separator: "/")

            titleLabel.text = genres + " (" + String(filmInfo.yearFirstRelease) + ")"

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

            imageView.contentMode = .scaleAspectFill
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: URL(string: filmInfo.imageUrl))

            contentView.addSubview(imageView.prepareForAutoLayout())
            imageView.topAnchor ~= contentView.topAnchor + 11
            imageView.centerXAnchor ~= contentView.centerXAnchor
            imageView.widthAnchor ~= windowWidth
            imageView.heightAnchor ~= windowWidth / 800 * 1_185
            imageView.layer.cornerRadius = 5.0
            imageView.layer.masksToBounds = true

            setYoutube(videoID: filmInfo.trailer)

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

//            contentView.addSubview(buyButton.prepareForAutoLayout())
//            buyButton.topAnchor ~= willStack.bottomAnchor + 36
//            buyButton.centerXAnchor ~= contentView.centerXAnchor
//
//            contentView.addSubview(inviteButton.prepareForAutoLayout())
//            inviteButton.topAnchor ~= buyButton.bottomAnchor + 15
//            inviteButton.centerXAnchor ~= contentView.centerXAnchor

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
            infoStack.topAnchor ~= willStack.bottomAnchor + 35
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

    func setYoutube(videoID: String) {

        self.videoID = videoID

        if videoID.count >= 1 {
            contentView.addSubview(playButton.prepareForAutoLayout())
            playButton.centerXAnchor ~= imageView.centerXAnchor
            playButton.centerYAnchor ~= imageView.centerYAnchor
            playButton.heightAnchor ~= 100
            playButton.widthAnchor ~= 100
            playButton.setImage(Asset.Cinema.play.image, for: .normal)
            playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)

            loadYT(videoID: videoID)

//            youtubeView.cueVideo(
//                byId: videoID,
//                startSeconds: 0,
//                suggestedQuality: .auto
//            )
        }
    }

    func setInfo2(_ filmInfo: FullFilm) {

        textView.text = filmInfo.description
        descriptions = filmInfo.description

        textView.font = UIFont.cnmFutura(size: 14)
        textView.textColor = UIColor.cnmGreyLight
        textView.textAlignment = .left
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
        rolesCV.delegate = self
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

    func didTapHomeButton() {
        output?.homeTap()
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
            output.watchedTap(rate: 0)
//            showAlert(message: L10n.filmWatchAlert)
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
        output?.tapReviews(name: name, genres: genres)
    }

    func didTapPlayButton() {
        youtubeView.cueVideo(
            byId: videoID,
            startSeconds: 0,
            suggestedQuality: .auto
        )
        youtubeView.playVideo()
    }

    func fbClick() {

//        let loginManager = LoginManager()
//        loginManager.logIn(readPermissions: [ .publicProfile], viewController: self) { loginResult in
//            switch loginResult {
//            case .failed(let error):
//              //  self.activityView.stopAnimating()
//                print(error)
//            case .cancelled:
//                //self.activityView.stopAnimating()
//                print("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let token):
//                 print("User cancelled login.")
//               // self.loginService.loginByFB(with: token.authenticationToken, deviceId: token.userId!)
//            }
//        }

        // Create an object
//        let object: OpenGraphObject = [
//            "og:type": "books.book",
//            "og:title": "A Game of Thrones",
//            "og:description": "In the frozen wastes to the north of Winterfell, sinister and supernatural forces are mustering.",
//            "books:isbn": "0-553-57340-3"
//        ]

        //let object: OpenGraphObject = OpenGraphObject(dictionaryLiteral: ( "og:type", "books.book"))

        // Create an action
        if let image = imageView.image {

           // FBSDKShareMediaContent 

//            let content: FBSDKShareLinkContent = FBSDKShareLinkContent()
//            content.contentURL = URL(string: "http://developers.facebook.com")
//            FBSDKShareDialog.show(from: self, with: content, delegate: nil)

//            let title = "FacebookSdk GOVNO!"
//
//            let photo: FBSDKSharePhoto = FBSDKSharePhoto()
//            photo.image = image
//            photo.isUserGenerated = true
//
//            var properties: [AnyHashable: Any] = [
//                "og:type": "article",
//                "og:title": title,
//                "og:image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCalqoke09R7bu90lK8LYMLVeZ4KBqap0xZohNSJG3sCva_auMbw"
//            ]
//            @"og:description":contentDesc
        // Create an object

0
      // FBSDKShareDialog.show(from: self, with: content, delegate: nil)

        }
//        var action = OpenGraphAction(type: "book.reads")
//        action["books:book"] = OpenGraphObject(dictionaryLiteral: ( "og:type", "books.book"))
//
//        // Create the content
//        var content = OpenGraphShareContent()
//        content.action = action
//        content.previewPropertyName = "books:book"
//
//        // let dialog = ShareDialog(content: content)
//
////        do {
////            try ShareDialog.show(content: content)
////        } catch (let error) {
////            print()
////        }
//
        if let image = imageView.image {
            let vkShare = VKShareDialogController()
            if let info = titleLabel.text {
                vkShare.text = name + ". " + info + " " + descriptions
            }

            let img = VKUploadImage(image: image, andParams: nil)
            let link = URL(string: Configurations.linkShare)
            vkShare.shareLink = VKShareLink(title: "Cinemad", link: link)
            vkShare.uploadImages = [img as Any]

            vkShare.completionHandler = { result, str  in
                self.dismiss(animated: true, completion: nil)
            }

            present(vkShare, animated: true, completion: nil)
        }

    }


    func didTapSharingButton() {
        fbClick()
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

extension FilmViewController: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print()
    }

    func vkSdkUserAuthorizationFailed() {
        print()
    }
}

// MARK: - FilmViewInput

extension FilmViewController: RolesCVDelegate {
    func openPersonID(_ personID: String, name: String, role: String) {
        if let filmInfo = filmInformation {
            output?.openPersonID(personID, name: name, role: role, persons: filmInfo.persons)
        }
    }
}
