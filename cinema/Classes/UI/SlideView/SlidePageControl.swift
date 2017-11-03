//
//  SlidePageControl.swift
//  cinema
//
//  Created by Mac on 31.08.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class SlidePageControl: UIView {

    private var indicatorViews: [UIView] = []
    let stackView = UIStackView()

    var currentPage: Int = 0
    var countPage: Int = 0 {
        didSet {
            for i in 0..<countPage {
                let indicator = UIView(frame: CGRect(x: 0, y: 0, width: 11, height: 11))
                indicator.backgroundColor = i == 0 ? UIColor.darkGray : UIColor.lightGray
                indicator.layer.cornerRadius = 5.5
                indicatorViews.append(indicator)
                stackView.addArrangedSubview(indicatorViews[i])
            }
            stackView.widthAnchor ~= 11 * CGFloat(indicatorViews.count) + max((CGFloat(indicatorViews.count) - 1) * 15, 0)
        }
    }

    override init(frame: CGRect) {

        super.init(frame: frame)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        addSubview(stackView.prepareForAutoLayout())
        stackView.pinEdgesToSuperviewEdges()
        stackView.heightAnchor ~= 11
    }

    func setSlide(_ number: Int) {
        for i in 0..<countPage {
            indicatorViews[i].backgroundColor = i == number ? UIColor.darkGray : UIColor.lightGray
        }
        currentPage = number
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
