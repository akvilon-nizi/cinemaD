//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Kingfisher

class ImageView: UIImageView {

    var isRounded: Bool = false {
        didSet {
            layer.cornerRadius = isRounded ? 5 : 0
        }
    }

    required init(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(frame: .zero)

        contentMode = .scaleAspectFill
        clipsToBounds = true
        backgroundColor = .fdlPaleGrey
    }

    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
}
