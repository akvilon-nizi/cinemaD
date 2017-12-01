//
//  YoutubeViewCell.swift
//  cinema
//
//  Created by User on 08.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import YouTubeiOSPlayerHelper
import AVFoundation
import RxSwift

class YoutubeViewCell: UICollectionViewCell {
    @objc fileprivate let youtubeView = YTPlayerView()
    fileprivate let isShowYoutube = false
    fileprivate let previewImageView = UIImageView()
    fileprivate let playButton = UIImageView(image: Asset.Cinema.play.image)
    var player: AVPlayer?
    var isLoad: Bool = false
    var isPlay: Bool = false
    var isObsever: Bool = false

    let disposeBag = DisposeBag()

    let activityVC = UIActivityIndicatorView()

    var idVideo: String = "" {
        didSet {
            if let url = URL(string: idVideo),
                url.absoluteString.contains("youtube.com/embed/") {

                let path = (url.path as NSString).replacingOccurrences(of: "/embed/", with: "")
                if path != "" {
                    previewImageView.kf.setImage(with: URL(string: String(format: "https://img.youtube.com/vi/%@/maxresdefault.jpg", path)))
                    //                  youtubeView.frame = previewImageView.frame
                }
            }
            playVideo()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    //    override func prepareForReuse() {
    //        super.prepareForReuse()
    //        idVideo = ""
    //        isLoad = false
    //    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(youtubeView.prepareForAutoLayout())
        youtubeView.pinEdgesToSuperviewEdges()
        youtubeView.layer.cornerRadius = 5.0
        youtubeView.layer.masksToBounds = true
        youtubeView.isUserInteractionEnabled = false
        youtubeView.delegate = self

        contentView.addSubview(previewImageView)
        previewImageView.pinEdgesToSuperviewEdges()
        previewImageView.kf.indicatorType = .activity
        previewImageView.layer.cornerRadius = 5.0
        previewImageView.layer.masksToBounds = true

        previewImageView.addSubview(playButton.prepareForAutoLayout())
        playButton.centerXAnchor ~= previewImageView.centerXAnchor
        playButton.centerYAnchor ~= previewImageView.centerYAnchor
        playButton.heightAnchor ~= 51
        playButton.widthAnchor ~= 51

        activityVC.isHidden = true

        NotificationCenter.default.addObserver(self, selector: #selector(assa), name: NSNotification.Name(rawValue: "AVPlayerItemBecameCurrentNotification"), object: nil)

        //        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        //        previewImageView.addGestureRecognizer(tap)
        //loadPlayer()

    }

    func assa(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            self.player = nil
            if let player = playerItem.value(forKey: "player") as? AVPlayer {
                self.player = player
                player.isMuted = true
            }

        }
    }

    func playVideo() {

        // isPlay = true
        youtubeView.playVideo()
        youtubeView.isUserInteractionEnabled = false
        //        activityVC.isHidden = false
        //        activityVC.startAnimating()
        //        playButton.isHidden = true
        //        do {
        //            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionModeVideoRecording)
        //            try AVAudioSession.sharedInstance().setActive(true)
        //        } catch _ {
        //            print("couldn't set session")
        //        }

    }

    func fullScreen() {
        youtubeView.webView?.allowsInlineMediaPlayback = false
        isPlay = false
        youtubeView.pauseVideo()
        //isPlay = true
        youtubeView.playVideo()
        let deadlineTime = DispatchTime.now() + .microseconds(100_000)
        isPlay = true

        if !isLoad {
            print("not assa")
        }

        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.youtubeView.webView?.allowsInlineMediaPlayback = true
            if let player = self.player {
                player.isMuted = false
            }
            self.isPlay = true
        }
    }

    func stopVideo() {

        // isPlay = false
        youtubeView.stopVideo()
        youtubeView.isUserInteractionEnabled = false
        youtubeView.webView?.allowsInlineMediaPlayback = false
        activityVC.isHidden = false
        activityVC.startAnimating()
        playButton.isHidden = true

    }

    func loadYT() {
        youtubeView.load(withVideoId: "", playerVars: [
            "playsinline": 1,
            "disablekb": 0,
            "iv_load_policy": 3,
            "rel": 0,
            "modestbranding": 1,
            "enablejsapi": 1,
            "autoplay": 1,
            "controls": 0
            ])
    }

    // MARK: - Private methods

    func loadPlayer() {
        if !isLoad {
            loadYT()
            isLoad = true
        } else {
            if idVideo != "" {
                isLoad = true
                if let url = URL(string: idVideo),
                    url.absoluteString.contains("youtube.com/embed/") {

                    let path = (url.path as NSString).replacingOccurrences(of: "/embed/", with: "")
                    if path != "" {
                        youtubeView.playVideo()
                        //contentView.bringSubview(toFront: previewImageView)
                        contentView.sendSubview(toBack: youtubeView)
                        youtubeView.isUserInteractionEnabled = false
                        playButton.isHidden = true
                        youtubeView.cueVideo(
                            byId: path,
                            startSeconds: self.youtubeView.currentTime(),
                            suggestedQuality: .auto
                        )
                    }
                }
            }
        }
    }

    static var reuseIdentifier: String {
        return "YoutubeViewCell"
    }
}

// MARK: YTPlayerViewDelegate

extension YoutubeViewCell: YTPlayerViewDelegate {

    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if state == .playing {
            activityVC.isHidden = true
            activityVC.stopAnimating()
            //isPlay = true
            contentView.sendSubview(toBack: previewImageView)
            contentView.bringSubview(toFront: youtubeView)
        }
        if state == .paused {
            if isPlay {
                player?.isMuted = true
                playVideo()
                isPlay = false
            }
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        loadPlayer()
        playVideo()
    }
}
