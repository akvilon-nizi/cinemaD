//
//  MessageView.swift
//  cinema
//
//  Created by User on 22.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - WMessageView

protocol MessageViewDelegate: class {
    func close()
    func sendMessage(_ message: String)
}

class MessageView: UIView {

    fileprivate let closeButton = UIButton()
    fileprivate let sendButton = UIButton()

    fileprivate let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.cnmFutura(size: 14)
        textView.text = L10n.newsMessagePlaceholder
        textView.textColor = UIColor.lightGray
        textView.tintColor = UIColor.cnmMainOrange
        return textView
    }()

    weak var delegate: MessageViewDelegate?

    override init(frame: CGRect) {

        super.init(frame: frame)
        backgroundColor = .white
        textView.delegate = self

        let separatorView = UIView()
        separatorView.backgroundColor = .cnmDadada
        addSubview(separatorView.prepareForAutoLayout())
        separatorView.trailingAnchor ~= trailingAnchor
        separatorView.leadingAnchor ~= leadingAnchor
        separatorView.heightAnchor ~= 1
        separatorView.topAnchor ~= topAnchor

        closeButton.addTarget(self, action: #selector(handleTapCloseButton), for: .touchUpInside)
        closeButton.setImage(Asset.Kinobase.close.image, for: .normal)
        closeButton.heightAnchor ~= 35
        closeButton.widthAnchor ~= 35

        addSubview(closeButton.prepareForAutoLayout())
        closeButton.centerYAnchor ~= centerYAnchor
        closeButton.leadingAnchor ~= leadingAnchor + 4

        sendButton.addTarget(self, action: #selector(handleTapSendButton), for: .touchUpInside)
        sendButton.setImage(Asset.Kinobase.enter.image, for: .normal)
        sendButton.heightAnchor ~= 35
        sendButton.widthAnchor ~= 35

        addSubview(sendButton.prepareForAutoLayout())
        sendButton.centerYAnchor ~= centerYAnchor
        sendButton.trailingAnchor ~= trailingAnchor - 4

        addSubview(textView.prepareForAutoLayout())
        textView.topAnchor ~= topAnchor + 5
        textView.leadingAnchor ~= closeButton.trailingAnchor + 10
        textView.trailingAnchor ~= sendButton.leadingAnchor - 10

        let separatorTextView = UIView()
        separatorTextView.backgroundColor = UIColor.cnmMainOrange
        addSubview(separatorTextView.prepareForAutoLayout())
        separatorTextView.widthAnchor ~= textView.widthAnchor
        separatorTextView.leadingAnchor ~= textView.leadingAnchor
        separatorTextView.heightAnchor ~= 1
        separatorTextView.topAnchor ~= textView.bottomAnchor + 1
        separatorTextView.bottomAnchor ~= bottomAnchor - 10

    }

    // MARK: - Actions

    func handleTapCloseButton() {
        clearTextView()
        delegate?.close()
    }

    func handleTapSendButton() {
        if textView.textColor != UIColor.lightGray {
            delegate?.sendMessage(textView.text)
            clearTextView()
        }
    }

    func clearTextView() {
        textView.resignFirstResponder()
        textView.text = L10n.newsMessagePlaceholder
        textView.textColor = UIColor.lightGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MessageView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.cnmGreyDark
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = L10n.newsMessagePlaceholder
            textView.textColor = UIColor.lightGray
        }
    }
}
