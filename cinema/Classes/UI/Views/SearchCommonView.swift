//
//  SearchCommonView.swift
//  cinema
//
//  Created by iOS on 11.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift

protocol SearchCommonDelegate: class {
    func changeText(_ text: String)
    func tapFilter()
}

class SearchCommonView: UIView {

    fileprivate let disposeBag = DisposeBag()

    fileprivate let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    weak var delegate: SearchCommonDelegate?

    fileprivate let rightButton = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))

    fileprivate let activityVC = UIActivityIndicatorView()

    fileprivate let titleField = UITextField()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)

//        let separatorView = UIView()
//        separatorView.backgroundColor = .cnmDadada
//        addSubview(separatorView.prepareForAutoLayout())
//        separatorView.bottomAnchor ~= bottomAnchor - 4
//        separatorView.trailingAnchor ~= trailingAnchor - 24
//        separatorView.leadingAnchor ~= leadingAnchor + 24
//        separatorView.heightAnchor ~= 1

        addSubview(titleField.prepareForAutoLayout())
        titleField.placeholder = L10n.filmSearchPlaceholder
        titleField.trailingAnchor ~= trailingAnchor - 20
        titleField.leadingAnchor ~= leadingAnchor
        titleField.topAnchor ~= topAnchor + 5

        let searchImageView = UIImageView(image: Asset.Search.search.image)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 62, height: 18)
        leftView.addSubview(searchImageView)
        searchImageView.frame = CGRect(x: 32, y: 0, width: 19, height: 18)

//        rightButton.setImage(Asset.Search.type.image, for: .normal)
//        rightButton.addTarget(self, action: #selector(typeButtonTap), for: .touchUpInside)
        activityVC.activityIndicatorViewStyle = .gray
        activityVC.hidesWhenStopped = true
        activityVC.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
//        rightView.addSubview(rightButton)
        titleField.rightView = activityVC
        titleField.rightViewMode = .always

        titleField.leftView = leftView
        titleField.leftViewMode = .always

        titleField.rx.text.orEmpty
            .skip(1)
            .throttle(1.5, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] query in
                self?.getVideoID(query)
                if !query.isEmpty {
                    self?.activityVC.startAnimating()
                }
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }

    func hiddenFilter() {
        titleField.rightViewMode = .never
    }

    func typeButtonTap() {
        delegate?.tapFilter()
    }

    func getVideoID(_ query: String) {
        delegate?.changeText(query)
    }

    func hiddenActivityVC() {
        activityVC.stopAnimating()
    }

    func removeQuery() {
        getVideoID("")
        titleField.text = ""
        activityVC.stopAnimating()
    }
}
