//
//  HeaderSearchView.swift
//  cinema
//
//  Created by User on 05.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol HeaderSearchDelegate: class {
    func changeText(_ text: String)
    func tapFilter()
}

class HeaderSearchView: UITableViewHeaderFooterView {

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    fileprivate let disposeBag = DisposeBag()

    fileprivate let windowWidth = UIWindow(frame: UIScreen.main.bounds).bounds.width - 60

    weak var delegate: HeaderSearchDelegate?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

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

        let rightButton = UIButton(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        rightButton.setImage(Asset.Search.type.image, for: .normal)
        rightButton.addTarget(self, action: #selector(typeButtonTap), for: .touchUpInside)
        let rightView = UIView()
        rightView.frame = CGRect(x: 0, y: 0, width: 68, height: 20)
        rightView.addSubview(rightButton)
        titleField.rightView = rightView
        titleField.rightViewMode = .always

        titleField.rx.text.orEmpty
            .skip(1)
            .throttle(3, scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] query in
                self?.getVideoID(query)
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }

    func typeButtonTap() {
        delegate?.tapFilter()
    }

    func getVideoID(_ query: String) {
        delegate?.changeText(query)
    }

}
