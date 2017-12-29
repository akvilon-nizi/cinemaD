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

    //var videoID: String = ""

    fileprivate let playButton = UIButton()

    let contentView = UIView()
    let imageView = UIImageView()
    let scrollView = UIScrollView()

    let willWatchButton = UIButton().setParameters(L10n.filmWillWatchButton)

    let textView = ReadMoreTextView()

    let desriptionLabel = UILabel()

    var descriptions: String = ""

    let titleLabel = UILabel()

    let watchedButton = UIButton().setParameters(L10n.filmWatchedButton)

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

    let inviteButton = UIButton().inviteButton()

    let starsLabel = UILabel()

    let starsView = UIView()

    var starsButons: [StarView] = []

    let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 160

    let youtubeIndicator = UIActivityIndicatorView()

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

//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        print()
//    }

    fileprivate let youtubeView = YTPlayerView()

    override var prefersStatusBarHidden: Bool {
       // edgesForExtendedLayout = []
        view.layoutSubviews()
        view.layoutIfNeeded()
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()

        if #available(iOS 11.0, *) {
            definesPresentationContext = true
        }

       // edgesForExtendedLayout = []

        let sdk = VKSdk.initialize(withAppId: "6258240")
        //sdk?.register(self)
        //sdk.ui

        activityVC.isHidden = false
        activityVC.startAnimating()

        automaticallyAdjustsScrollViewInsets = true

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
        titleLabel.lineBreakMode = .byTruncatingMiddle

        titleView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.centerXAnchor ~= titleView.centerXAnchor
        titleLabel.topAnchor ~= titleViewLabel.bottomAnchor
        titleLabel.widthAnchor ~= windowWidth + 20
        titleLabel.textAlignment = .center

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
        playButton.isHidden = true
        youtubeIndicator.isHidden = false
        youtubeIndicator.startAnimating()
        //self.videoID = videoID
        youtubeView.delegate = self
        youtubeView.load(withVideoId: videoID, playerVars: [
            "playsinline": 1,
            "disablekb": 1,
            "iv_load_policy": 3,
            "rel": 0,
            "modestbranding": 1
            ])

//        youtubeView.webView?.autoresizesSubviews = true
//        youtubeView.webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        youtubeView.webView?.allowsInlineMediaPlayback = false
//        youtubeView.webView?.frame = CGRect(x: 0, y: 0, width: 320, height: 2_000)
    }

    func setInfo() {
        if let filmInfo = filmInformation {

            myRate = Int(filmInfo.myRate)

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

            imageView.addSubview(youtubeIndicator.prepareForAutoLayout())
            youtubeIndicator.centerXAnchor ~= imageView.centerXAnchor
            youtubeIndicator.centerYAnchor ~= imageView.centerYAnchor
            youtubeIndicator.isHidden = true

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

            let infoStack = createStackView(.horizontal, .fill, .fill, 0, with: [
                UIView().setParameters(
                    topLabelText: filmInfo.rateTmdb == 0 ? "-" : String(filmInfo.rateTmdb),
                    bottomLabelText: L10n.filmTmdbText),
                UIView().setParameters(
                    topLabelText: filmInfo.duration == 0 ? "-" : String(filmInfo.duration) + " мин",
                    bottomLabelText: L10n.filmDurationText),
                UIView().setParameters(
                    topLabelText: filmInfo.ageLimit == "" ? "-" : (filmInfo.ageLimit)!,
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

        //self.videoID = videoID

        if videoID.count >= 1 {
            contentView.addSubview(playButton.prepareForAutoLayout())
            playButton.centerXAnchor ~= imageView.centerXAnchor
            playButton.centerYAnchor ~= imageView.centerYAnchor
            playButton.heightAnchor ~= 100
            playButton.widthAnchor ~= 100
            playButton.setImage(Asset.Cinema.play.image, for: .normal)
            playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)

            loadYT(videoID: videoID)
        }
    }

    func setInfo2(_ filmInfo: FullFilm) {

        textView.text = filmInfo.description
        descriptions = filmInfo.description

        textView.attributedReadMoreText = NSAttributedString(string: L10n.filmMoreButton, attributes: [
            NSForegroundColorAttributeName: UIColor.cnmBlueLight,
            NSFontAttributeName: UIFont.cnmFutura(size: 14)
            ])
        textView.font = UIFont.cnmFutura(size: 14)
        textView.textColor = UIColor.cnmGreyLight
        textView.textAlignment = .left
        textView.maximumNumberOfLines = 4
        textView.shouldTrim = true

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
                "-", bottomLabelText: L10n.filmBudjetText), UIView().separator(),
            UIView().setParameters2(topLabelText: filmInfo.gross > 0
                ? String(filmInfo.gross).setPriceMask() + " $"
                : "-", bottomLabelText: L10n.filmCashText)])
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

        activityVC.isHidden = false
        activityVC.startAnimating()
        view.bringSubview(toFront: activityVC)

        if !watchedButton.isSelected {
            output.watchedTapDelete()
        } else {
            animation(isWatch: true)
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
            animation(isWatch: false)
        } else {
            output.willWatchTapDelete()
        }

    }

    func animation(isWatch: Bool) {
        var frame = imageView.convert(imageView.frame, to: view)
        frame.origin.x -= view.frame.size.width / 2 - imageView.frame.size.width / 2
        let doubleImageView = UIImageView()
        doubleImageView.image = imageView.image
        doubleImageView.frame = frame
        view.addSubview(doubleImageView)
        UIView.animate(withDuration: 2.0, animations: {
            frame.origin.x = isWatch ? -800 : 800
            frame.origin.y = 2_000
            frame.size.height = 0
            frame.size.width = 0
            doubleImageView.frame = frame
        }, completion: { _ in
            doubleImageView.removeFromSuperview()
        })
    }

    func didTapStarButton(button: UIButton) {
        setStars(button.tag + 1)
        output.watchedTap(rate: button.tag + 1)
        activityVC.isHidden = false
        activityVC.startAnimating()
    }

    func didTapChatButton() {
        if let fullFilm = filmInformation {
            output?.tapReviews(fullFilm)
        }
    }

    func didTapPlayButton() {
        playButton.isHidden = true
        youtubeIndicator.isHidden = false
        youtubeIndicator.startAnimating()
        youtubeView.playVideo()
    }

    func didTapSharingButton() {
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

    func setStars(_ tag: Int) {
//        myRate = tag
//
//            for starView in starsButons {
//
//                if tag == 0 {
//                    starView.setState(false, labelIsHidden: true)
//                    continue
//                }
//
//                if starView.button.tag <= tag - 1 {
//                    starView.setState(true, labelIsHidden: starView.button.tag != tag - 1)
//                } else {
//                    starView.setState(false, labelIsHidden: true)
//                }
//            }
    }
}

// MARK: - FilmViewInput

extension FilmViewController: FilmViewInput {

    func showNetworkError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
        stopAnimating()
    }

    func setFilmInfo(_ filmInfo: FullFilm) {
        self.filmInformation = filmInfo
        stopAnimating()
        activityVC.color = UIColor.cnmMainOrange
        setInfo()
    }

    func statusChange() {
        stopAnimating()
    }

    func setStatus(_ rate: Double) {
        stopAnimating()
    }

    func stopAnimating() {
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

extension FilmViewController: RolesCVDelegate {
    func openPersonID(_ personID: String, name: String, role: String) {
        if let filmInfo = filmInformation {
            output?.openPersonID(personID, name: name, role: role, persons: filmInfo.persons)
        }
    }
}

extension UIButton {
    func setParameters(_ title: String) -> UIButton {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.cnmAfafaf, for: .normal)
        self.setTitleColor(UIColor.cnmMainOrange, for: .selected)
        self.titleLabel?.font = UIFont.cnmFuturaLight(size: 16)
        self.heightAnchor ~= 33
        self.widthAnchor ~= (UIWindow(frame: UIScreen.main.bounds).bounds.width - 1) / 2
        return self
    }
}

// MARK: YTPlayerViewDelegate

extension FilmViewController: YTPlayerViewDelegate {

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .playing {
            if youtubeView.currentTime() == 0 {
                self.isHidden()
            }
        }
        if state == .paused {
            if youtubeView.currentTime() > 0 {
                self.isHidden()
            }
            UIApplication.shared.isStatusBarHidden = false
            setNeedsStatusBarAppearanceUpdate()

        }
    }

    func isHidden() {
        self.playButton.isHidden = false
        self.youtubeIndicator.isHidden = true
        self.youtubeIndicator.stopAnimating()
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        isHidden()
    }
}
