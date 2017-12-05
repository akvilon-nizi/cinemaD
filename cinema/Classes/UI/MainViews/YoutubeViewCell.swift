//
//  YoutubeViewCell.swift
//  cinema
//
//  Created by User on 08.10.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import YouTubeiOSPlayerHelper

class YoutubeViewCell: UICollectionViewCell {
    fileprivate let youtubeView = YTPlayerView()
    fileprivate let isShowYoutube = false
    fileprivate let previewImageView = UIImageView()
    fileprivate let playButton = UIImageView(image: Asset.Cinema.play.image)

    var isLoad: Bool = false
    var isPlay: Bool = true

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
        youtubeView.layer.cornerRadius = 15.0
        youtubeView.layer.masksToBounds = true
        youtubeView.isUserInteractionEnabled = false
        youtubeView.delegate = self

        contentView.addSubview(previewImageView.prepareForAutoLayout())
        previewImageView.pinEdgesToSuperviewEdges()
        previewImageView.kf.indicatorType = .activity
        previewImageView.layer.cornerRadius = 15.0
        previewImageView.layer.masksToBounds = true

        previewImageView.addSubview(playButton.prepareForAutoLayout())
        playButton.centerXAnchor ~= previewImageView.centerXAnchor
        playButton.centerYAnchor ~= previewImageView.centerYAnchor
        playButton.heightAnchor ~= 51
        playButton.widthAnchor ~= 51

        previewImageView.addSubview(activityVC.prepareForAutoLayout())
        activityVC.centerXAnchor ~= previewImageView.centerXAnchor
        activityVC.centerYAnchor ~= previewImageView.centerYAnchor
        activityVC.activityIndicatorViewStyle = .whiteLarge
        activityVC.color = UIColor.cnmGreyDark

        activityVC.isHidden = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
        previewImageView.addGestureRecognizer(tap)
        loadPlayer()

    }

    func playVideo() {

        youtubeView.playVideo()
        youtubeView.isUserInteractionEnabled = true
        activityVC.isHidden = false
        activityVC.startAnimating()
        playButton.isHidden = true

    }
    func loadYT() {
        youtubeView.load(withVideoId: "", playerVars: [
            "playsinline": 1,
            "disablekb": 1,
            "iv_load_policy": 3,
            "rel": 0,
            "modestbranding": 1
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
                        youtubeView.pauseVideo()
                        contentView.bringSubview(toFront: previewImageView)
                        contentView.sendSubview(toBack: youtubeView)
                        youtubeView.isUserInteractionEnabled = false
                        playButton.isHidden = false
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
            contentView.sendSubview(toBack: previewImageView)
            contentView.bringSubview(toFront: youtubeView)
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        loadPlayer()
    }
}
