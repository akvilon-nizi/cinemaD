//
//  LineLayout.swift
//  cinema
//
//  Created by iOS on 23.11.17.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

class LineLayout: UICollectionViewFlowLayout {

    private var layoutAttributes: [UICollectionViewLayoutAttributes] = []

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        layoutAttributes = []
        if let superLayoutAttributes = super.layoutAttributesForElements(in: rect), let colView = collectionView {
            let collectionViewCenterX = colView.bounds.width * 0.5

            superLayoutAttributes.forEach { attributes in
                // swiftlint:disable:next force_cast
                let copyLayout = attributes.copy() as! UICollectionViewLayoutAttributes
                var deltaX = abs(collectionViewCenterX - (copyLayout.center.x - colView.contentOffset.x))
                if deltaX < colView.bounds.width - 60 {
                    let scale = 1.0 - deltaX / collectionViewCenterX * deltaX / collectionViewCenterX
                    var center = copyLayout.center
                    if (collectionViewCenterX - (copyLayout.center.x - colView.contentOffset.x)) > 0 {
                        center.x += (1 - scale) * collectionViewCenterX / 4
                    } else {
                        center.x -= (1 - scale) * collectionViewCenterX / 4
                    }

                    copyLayout.center = center

                }

                deltaX = abs(collectionViewCenterX - (copyLayout.center.x - colView.contentOffset.x))
                if deltaX < colView.bounds.width - 60 {
                    let scale = 1.0 - deltaX / collectionViewCenterX
                    copyLayout.transform = CGAffineTransform(scaleX: scale, y: scale)
                }

                layoutAttributes.append(copyLayout)
            }
        }
        return layoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
