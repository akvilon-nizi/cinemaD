//
//  EditProfile.swift
//  foodle
//
//  Created by incetro on 27/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - EditProfileAnimator

class EditProfileAnimator {

    private var neededToHide = false

    private var disposeBag = DisposeBag()

    func keyboardHeight() -> Observable<CGFloat> {

        return Observable.from([

                NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow) .map { notification -> CGFloat in

                    (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                },

                NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillHide) .map { _ -> CGFloat in 0 }

            ]).merge()
    }

    func setup(withConstraint constraint: NSLayoutConstraint, rootView: UIView) {

        keyboardHeight().observeOn(MainScheduler.instance).subscribe(onNext: { (keyboardHeight: CGFloat) in

            guard (abs(constraint.constant) < keyboardHeight) || (self.neededToHide) else {

                return
            }

            if keyboardHeight == 0 {

                self.neededToHide = false
                constraint.constant = -(rootView.frame.height - ProfileHeaderView.height - 280)

            } else {

                self.neededToHide = true
                constraint.constant = -(keyboardHeight + 20)
            }

            UIView.animate(withDuration: 0.2, animations: {

                rootView.layoutIfNeeded()
            })

        }).addDisposableTo(disposeBag)
    }
}
