//
//  SpinnerView.swift
//  foodle
//
//  Created by incetro on 18/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - SpinnerView

class SpinnerView: UIImageView {

    private var isStarted = false

    override init(frame: CGRect) {

        super.init(frame: frame)

        image = Asset.Restaurant.restaurantSpinner.image
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {

        isStarted = true
        isHidden = false

        UIView.animate(withDuration: 0.15, delay: 0, options: .curveLinear, animations: {

            self.transform = self.transform.rotated(by: CGFloat(Double.pi / 2.0))

        }, completion: { _ in

            if self.isStarted {

                self.start()
            }
        })
    }

    func stop() {

        isStarted = false
        isHidden = true
    }
}
