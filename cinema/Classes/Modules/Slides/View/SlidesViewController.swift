//
// Created by DanilaLyahomskiy on 30/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

class SlidesViewController: ParentViewController {

    var output: SlidesViewOutput!

    fileprivate let nextButton: UIButton = {

        let nextButton = UIButton()
        nextButton.setTitle(L10n.slideMainButton, for: .normal)
        nextButton.backgroundColor = UIColor.cnmMainOrange
        nextButton.layer.cornerRadius = 6.0
        nextButton.isHidden = true

        return nextButton
    }()

    fileprivate let slidePageControl: SlidePageControl = SlidePageControl()

    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 44, width: UIWindow(frame: UIScreen.main.bounds).frame.width, height: 320))
    var frame: CGRect = .zero

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

        let slidesArrayInfo = output.getSlidesArrayInfo()

        scrollView.delegate = self

        view.addSubview(scrollView.prepareForAutoLayout())
        scrollView.leadingAnchor ~= view.leadingAnchor
        scrollView.trailingAnchor ~= view.trailingAnchor
        scrollView.topAnchor ~= view.topAnchor

        let scrollSubview = UIView()

        for index in 0..<slidesArrayInfo.count {

            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size

            let subView = UIView(frame: frame)
            let slide: SlideView = SlideView()
            slide.slideInfo = slidesArrayInfo[index]

            subView.addSubview(slide.prepareForAutoLayout())
            slide.pinEdgesToSuperviewEdges()
            scrollSubview.addSubview(subView)
        }

        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(slidesArrayInfo.count), height: 520)

        scrollView.addSubview(scrollSubview.prepareForAutoLayout())
        scrollSubview.centerYAnchor ~= scrollView.centerYAnchor
        scrollSubview.widthAnchor ~= self.scrollView.frame.size.width * CGFloat(slidesArrayInfo.count)
        scrollSubview.heightAnchor ~= 520
        scrollSubview.centerXAnchor ~= scrollView.centerXAnchor + self.scrollView.frame.size.width

        addBottomSubview(slidesArrayInfo.count)
    }

    private func addBottomSubview(_ count: Int) {

        view.addSubview(nextButton.prepareForAutoLayout())
        nextButton.centerXAnchor ~= view.centerXAnchor
        nextButton.bottomAnchor ~= view.bottomAnchor - 45
        nextButton.heightAnchor ~= 49
        nextButton.widthAnchor ~= 177

        nextButton.addTarget(self, action: #selector(handleTapNextButton), for: .touchUpInside)

        view.addSubview(slidePageControl.prepareForAutoLayout())
        slidePageControl.centerXAnchor ~= view.centerXAnchor
        slidePageControl.bottomAnchor ~= nextButton.topAnchor - 21
        slidePageControl.topAnchor ~= scrollView.bottomAnchor
        slidePageControl.countPage = count
    }

    // MARK: - Actions 

    func handleTapNextButton() {
        if slidePageControl.currentPage != 2 {
            let currentPage = slidePageControl.currentPage + 1
            slidePageControl.setSlide(currentPage)
            let x = CGFloat(currentPage) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: x, y :0), animated: true)
        } else {
            output.nextActions()
        }
    }

    func handleTapContinueButton() {
        output.nextActions()
    }
}

// MARK: - SlidesViewInput

extension SlidesViewController: SlidesViewInput {

    func setupInitialState() {
    }
}

// MARK: - ScrollViewDelegate

extension SlidesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        offset.y = 0
        scrollView.contentOffset = offset
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        nextButton.isHidden = Int(pageNumber) != 2
        slidePageControl.setSlide(Int(pageNumber))
    }
}
