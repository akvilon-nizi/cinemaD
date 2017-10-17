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
//    fileprivate let previewImageView = UIImageView()
//    fileprivate let playButton = UIButton()

    var isLoad: Bool = false
    var isPlay: Bool = true

    var idVideo: String = ""

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(youtubeView.prepareForAutoLayout())
        youtubeView.pinEdgesToSuperviewEdges()
//        youtubeView.layer.cornerRadius = 5.0
//        youtubeView.layer.masksToBounds = true

        youtubeView.delegate = self
    }

    private func loadYT() {
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
                youtubeView.cueVideo(
                    byId: idVideo,
                    startSeconds: self.youtubeView.currentTime(),
                    suggestedQuality: .auto
                )
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
           // youtubeView.playVideo()
        }
    }

    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        loadPlayer()
    }
}
