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

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor - 4
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1

        let titleField = UITextField()
        addSubview(titleField.prepareForAutoLayout())
        titleField.placeholder = L10n.filmSearchPlaceholder
        titleField.trailingAnchor ~= trailingAnchor
        titleField.leadingAnchor ~= leadingAnchor
        titleField.bottomAnchor ~= separatorView.topAnchor - 11

        let searchImageView = UIImageView(image: Asset.Search.search.image)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 62, height: 18)
        leftView.addSubview(searchImageView)
        searchImageView.frame = CGRect(x: 32, y: 0, width: 19, height: 18)

        rightButton.setImage(Asset.Search.type.image, for: .normal)
        rightButton.addTarget(self, action: #selector(typeButtonTap), for: .touchUpInside)
        let rightView = UIView()
        rightView.frame = CGRect(x: 0, y: 0, width: 68, height: 20)
        rightView.addSubview(rightButton)
        titleField.rightView = rightView
        titleField.rightViewMode = .always

        titleField.leftView = leftView
        titleField.leftViewMode = .always

        titleField.rx.text.orEmpty
            .skip(1)
            .throttle(3, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] query in
                self?.getVideoID(query)
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }

    func hiddenFilter() {
        rightButton.isHidden = true
    }

    func typeButtonTap() {
        delegate?.tapFilter()
    }

    func getVideoID(_ query: String) {
        delegate?.changeText(query)
    }
}
