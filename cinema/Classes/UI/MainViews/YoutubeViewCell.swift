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
    fileprivate let playButton = UIButton(type: .system)

    var isLoad: Bool = false
    var isPlay: Bool = true

    var idVideo: String = ""
//    {
//        didSet {
//            if let url = URL(string: idVideo),
//                url.absoluteString.contains("youtube.com/embed/") {
//
//                let path = (url.path as NSString).replacingOccurrences(of: "/embed/", with: "")
//                if path != "" {
//                     previewImageView.kf.setImage(with: URL(string: String(format: "https://img.youtube.com/vi/%@/maxresdefault.jpg", path)))
//                }
//            }
//        }
//    }

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

        addSubview(youtubeView.prepareForAutoLayout())
        youtubeView.pinEdgesToSuperviewEdges()
        youtubeView.layer.cornerRadius = 5.0
        youtubeView.layer.masksToBounds = true

        youtubeView.delegate = self

//        addSubview(previewImageView.prepareForAutoLayout())
//        previewImageView.pinEdgesToSuperviewEdges()
//        previewImageView.kf.indicatorType = .activity
//        previewImageView.layer.cornerRadius = 5.0
//        previewImageView.layer.masksToBounds = true

//        playButton.setImage(Asset.Cinema.play.image, for: .normal)
//        previewImageView.addSubview(playButton.prepareForAutoLayout())
//        playButton.centerXAnchor ~= previewImageView.centerXAnchor
//        playButton.centerYAnchor ~= previewImageView.centerYAnchor
//        playButton.heightAnchor ~= 51
//        playButton.widthAnchor ~= 51

//        playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)

        let tap = UITapGestureRecognizer(target: self, action: #selector(playVideo))
//        tap.delegate = self
        previewImageView.addGestureRecognizer(tap)
//        loadPlayer()
    }

    func playVideo() {
        youtubeView.playVideo()
        bringSubview(toFront: youtubeView)
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
        if state == .queued {
//            youtubeView.playVideo()
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        loadPlayer()
    }
}
