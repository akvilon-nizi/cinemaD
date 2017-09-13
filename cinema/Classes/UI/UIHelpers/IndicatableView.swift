//
// Created by Александр Масленников on 21.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol Indicatable {

    func register(indication: Indication)
}

extension Indicatable where Self: UIView {

    func register(indication: Indication) {
        indication.containerView.isHidden = true
        self.addSubview(indication.containerView.prepareForAutoLayout())
        indication.containerView.pin(to: self, edgesInsets: indication.insets)

        indication.showHiddenState()
    }
}

extension UIView: Indicatable {

}
