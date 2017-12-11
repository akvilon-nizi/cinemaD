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
    func changeText(_ query: String)
}

class SearchCommonView: UIView {

    fileprivate let disposeBag = DisposeBag()

    fileprivate let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    weak var delegate: SearchCommonDelegate?

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)

        heightAnchor ~= 35

        let titleField = UITextField()
        addSubview(titleField.prepareForAutoLayout())
        titleField.placeholder = L10n.filmSearchPlaceholder
        titleField.trailingAnchor ~= trailingAnchor
        titleField.leadingAnchor ~= leadingAnchor
        titleField.topAnchor ~= topAnchor

        let searchImageView = UIImageView(image: Asset.Search.search.image)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 62, height: 18)
        leftView.addSubview(searchImageView)
        searchImageView.frame = CGRect(x: 32, y: 0, width: 19, height: 18)

        titleField.leftView = leftView
        titleField.leftViewMode = .always

        titleField.rx.text.orEmpty
            .skip(1)
            .throttle(3, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] query in
                self?.getVideoID(query)
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        addSubview(separatorView.prepareForAutoLayout())
        separatorView.bottomAnchor ~= bottomAnchor
        separatorView.trailingAnchor ~= trailingAnchor - 24
        separatorView.leadingAnchor ~= leadingAnchor + 24
        separatorView.heightAnchor ~= 1
    }

    func getVideoID(_ query: String) {
        delegate?.changeText(query)
    }
}
