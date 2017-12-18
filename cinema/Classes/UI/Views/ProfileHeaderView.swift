//
//  ProfileHeaderView.swift
//  cinema
//
//  Created by iOS on 18.12.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    let topLabel = UILabel()

    let contentView = UIView()

    let imageView = UIImageView()

    let bottomLabel = UILabel()

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init(_ isCenter: Bool = false) {
        super.init(frame: .zero)

        topLabel.font = UIFont.cnmFuturaLight(size: 16)
        topLabel.textColor = UIColor.cnmAfafaf
        topLabel.textAlignment = .center
        self.addSubview(topLabel.prepareForAutoLayout())
        topLabel.topAnchor ~= self.topAnchor
        topLabel.centerXAnchor ~= self.centerXAnchor

        self.addSubview(contentView.prepareForAutoLayout())
        contentView.centerXAnchor ~= self.centerXAnchor
        contentView.topAnchor ~= topLabel.bottomAnchor + 8
        contentView.bottomAnchor ~= self.bottomAnchor

        contentView.addSubview(imageView.prepareForAutoLayout())
        imageView.centerYAnchor ~= contentView.centerYAnchor
        imageView.leadingAnchor ~= contentView.leadingAnchor

        bottomLabel.font = UIFont.cnmFuturaLight(size: 17)
        bottomLabel.textColor = UIColor.setColorGray(white: 109)
        contentView.addSubview(bottomLabel.prepareForAutoLayout())
        bottomLabel.centerYAnchor ~= contentView.centerYAnchor
        bottomLabel.trailingAnchor ~= contentView.trailingAnchor
        bottomLabel.leadingAnchor ~= imageView.trailingAnchor + 6

        if isCenter {
            let leftView = UIView().separator()
            self.addSubview(leftView.prepareForAutoLayout())
            leftView.topAnchor ~= self.topAnchor
            leftView.leadingAnchor ~= self.leadingAnchor
            leftView.topAnchor ~= self.topAnchor

            let rightView = UIView().separator()
            self.addSubview(rightView.prepareForAutoLayout())
            rightView.topAnchor ~= self.topAnchor
            rightView.trailingAnchor ~= self.trailingAnchor
            rightView.topAnchor ~= self.topAnchor
        }

        let widthView: CGFloat = UIWindow(frame: UIScreen.main.bounds).bounds.width == 320 ? 99 : 110
        widthAnchor ~= widthView
        heightAnchor ~= 43
    }

    func setParameters(
        topLabelText: String,
        bottomLabelText: String,
        image: UIImage?,
        imageURL: String = "") {

        topLabel.text = topLabelText

        imageView.image = image

        if let img = image {
            imageView.image = img
        } else {
            imageView.kf.setImage(with: URL(string: imageURL))
        }

        bottomLabel.text = bottomLabelText
    }

    func setCount(text: String) {
         bottomLabel.text = text
    }
}

private extension UIView {
    func separator() -> UIView {
        self.heightAnchor ~= 43
        self.widthAnchor ~= 1
        self.backgroundColor = UIColor.cnmAfafaf
        return self
    }
}
