//
//  Created by Xander on 31.08.17.
//  Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

private struct Const {
    static let rotationStrength: CGFloat = 320
    static let rotationMax: CGFloat = 1.0
    static let rotationAngle: CGFloat = .pi * 0.125
    static let scaleStrength: CGFloat = 4.0
    static let scaleMax: CGFloat = 0.93
    static let actionMargin: CGFloat = 120
}

protocol SwipeableCardsDataSource: class {
    func numberOfTotalCards(in cards: SwipeableCards) -> Int
    func view(for cards: SwipeableCards, index: Int, reusingView: UIView?) -> UIView
}
protocol SwipeableCardsDelegate: class {
    func cards(_ cards: SwipeableCards, beforeSwipingItemAt index: Int)
    func cards(_ cards: SwipeableCards, didRemovedItemAt index: Int)
    func cards(_ cards: SwipeableCards, didLeftRemovedItemAt index: Int)
    func cards(_ cards: SwipeableCards, didRightRemovedItemAt index: Int)
}
extension SwipeableCardsDelegate {
    func cards(_ cards: SwipeableCards, beforeSwipingItemAt index: Int) {}
    func cards(_ cards: SwipeableCards, didRemovedItemAt index: Int) {}
    func cards(_ cards: SwipeableCards, didLeftRemovedItemAt index: Int) {}
    func cards(_ cards: SwipeableCards, didRightRemovedItemAt index: Int) {}
}

class SwipeableCards: UIView {

    weak var dataSource: SwipeableCardsDataSource? {
        didSet {
            reloadData()
        }
    }
    weak var delegate: SwipeableCardsDelegate?

    var showedCyclically = true
    var numberOfVisibleItems = 3
    var offset: (horizon: CGFloat, vertical: CGFloat) = (0, -10)

    /// If there is only one card, maybe you don't want to swipe it
    var swipeEnabled = true {
        didSet {
            panGestureRecognizer.isEnabled = swipeEnabled
        }
    }

    var topCard: UIView? {
        return visibleCards.first
    }

    required init?(coder _: NSCoder) {
        fatalError("NSCoding not supported")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        addGestureRecognizer(panGestureRecognizer)
    }

    func reloadData() {
        currentIndex = 0
        reusingView = nil
        visibleCards.removeAll()
        if let totalNumber = dataSource?.numberOfTotalCards(in: self) {
            let visibleNumber = min(totalNumber, numberOfVisibleItems)
            for i in 0..<visibleNumber {
                if let card = dataSource?.view(for: self, index: i, reusingView: reusingView) {
                    visibleCards.append(card)
                }
            }
        }
        layoutCards()
    }

    func swipe(to index: Int) {
        if let totalNumber = dataSource?.numberOfTotalCards(in: self), index < totalNumber {
            currentIndex = index
            reusingView = nil
            visibleCards.removeAll()
            let visibleNumber = min(totalNumber, numberOfVisibleItems)

            for i in 0..<visibleNumber {
                var newIndex = index + i
                var newCard: UIView?

                if newIndex < totalNumber {
                    newCard = dataSource?.view(for: self, index: newIndex, reusingView: reusingView)
                } else {
                    if showedCyclically {
                        if totalNumber == 1 {
                            newIndex = 0
                        } else {
                            newIndex %= totalNumber
                        }
                        newCard = dataSource?.view(for: self, index: newIndex, reusingView: reusingView)
                    }
                }

                if let card = newCard {
                    visibleCards.append(card)
                }
            }
            layoutCards()
        } else {
            log.warning("Wrong index")
        }
    }

    // Mark - Private
    fileprivate var currentIndex = 0
    fileprivate var reusingView: UIView?
    fileprivate var visibleCards = [UIView]()
    fileprivate var swipeEnded = true
    fileprivate lazy var panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragAction))
    fileprivate var xFromCenter: CGFloat = 0
    fileprivate var yFromCenter: CGFloat = 0
    fileprivate var originalPoint = CGPoint.zero
}

// MARK: - Fileprivate methods

private extension SwipeableCards {

    func layoutCards() {
        guard !visibleCards.isEmpty else {
            return
        }

        subviews.forEach { view in
            view.removeFromSuperview()
        }
        layoutIfNeeded()

        let width = frame.size.width
        let height = frame.size.height

        if let lastCard = visibleCards.last {
            let cardWidth = lastCard.frame.size.width
            let cardHeight = lastCard.frame.size.height

            if let totalNumber = dataSource?.numberOfTotalCards(in: self) {
                let visibleNumber = min(totalNumber, numberOfVisibleItems)

                var firstCardX = (width - cardWidth - CGFloat(visibleNumber - 1) * fabs(offset.horizon)) * 0.5
                if offset.horizon < 0 {
                    firstCardX += CGFloat(visibleNumber - 1) * fabs(offset.horizon)
                }
                var firstCardY = (height - cardHeight - CGFloat(visibleNumber - 1) * fabs(offset.vertical)) * 0.5
                if offset.vertical < 0 {
                    firstCardY += CGFloat(visibleNumber - 1) * fabs(offset.vertical)
                }

                //UIView.animate(withDuration: 0.08) {
                    for i in 0..<self.visibleCards.count {
                        let index = self.visibleCards.count - 1 - i   //add cards form back to front
                        let card = self.visibleCards[index]
                        card.transform = CGAffineTransform(rotationAngle: 0)
                        let size = card.frame.size
                        card.frame = CGRect(
                            x: firstCardX + CGFloat(index) * self.offset.horizon,
                            y: firstCardY + CGFloat(index) * self.offset.vertical,
                            width: size.width,
                            height: size.height
                        )
                        self.addSubview(card)
                    }
                //}
            }
        }

        for (index, card) in visibleCards.enumerated() {
            guard let swipeableCard = card as? Swipeable else {
                return
            }

            if index == 0 {
                swipeableCard.hideCover(animationDuration: 0.3)
            } else {
                let alpha = CGFloat(index) / CGFloat(visibleCards.count)
                swipeableCard.showCover(alpha: alpha, animationDuration: 0.3)

                let scale = card.frame.width / (card.frame.width - offset.vertical * 2 * CGFloat(index))
                let transform = CGAffineTransform(scaleX: scale, y: scale)
                card.transform = transform
            }
        }
    }

    @objc
    func dragAction(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard !visibleCards.isEmpty else {
            return
        }
        if let totalNumber = dataSource?.numberOfTotalCards(in: self) {
            if currentIndex > totalNumber - 1 {
                currentIndex = 0
            }
        }
        if swipeEnded {
            swipeEnded = false
            delegate?.cards(self, beforeSwipingItemAt: currentIndex)
        }
        if let firstCard = visibleCards.first {
            xFromCenter = gestureRecognizer.translation(in: firstCard).x  // positive for right swipe, negative for left
            yFromCenter = gestureRecognizer.translation(in: firstCard).y  // positive for up, negative for down
            switch gestureRecognizer.state {
            case .began:
                originalPoint = firstCard.center
            case .changed:
                let rotationStrength: CGFloat = min(xFromCenter / Const.rotationStrength, Const.rotationMax)
                let rotationAngel = Const.rotationAngle * rotationStrength
                let scale = max(1.0 - fabs(rotationStrength) / Const.scaleStrength, Const.scaleMax)
                firstCard.center = CGPoint(x: originalPoint.x + xFromCenter, y: originalPoint.y + yFromCenter)
                let transform = CGAffineTransform(rotationAngle: rotationAngel)
                let scaleTransform = transform.scaledBy(x: scale, y: scale)
                firstCard.transform = scaleTransform
            case .ended:
                afterSwipedAction(firstCard)
            default:
                break
            }
        }
    }

    func afterSwipedAction(_ card: UIView) {
        if xFromCenter > Const.actionMargin {
            rightActionFor(card)
        } else if xFromCenter < -Const.actionMargin {
            leftActionFor(card)
        } else {
            self.swipeEnded = true
            UIView.animate(withDuration: 0.3) {
                card.center = self.originalPoint
                card.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }

    func rightActionFor(_ card: UIView) {
        let finishPoint = CGPoint(x: 500, y: 2.0 * yFromCenter + originalPoint.y)
        UIView.animate(withDuration: 0.3, animations: {
            card.center = finishPoint
        }, completion: { _ in
            self.delegate?.cards(self, didRightRemovedItemAt: self.currentIndex)
            self.cardSwipedAction(card)
        })
    }

    func leftActionFor(_ card: UIView) {
        let finishPoint = CGPoint(x: -500, y: 2.0 * yFromCenter + originalPoint.y)
        UIView.animate(withDuration: 0.3, animations: {
            card.center = finishPoint
        }, completion: { _ in
            self.delegate?.cards(self, didLeftRemovedItemAt: self.currentIndex)
            self.cardSwipedAction(card)
        })
    }

    func cardSwipedAction(_ card: UIView) {
        swipeEnded = true
        card.transform = CGAffineTransform(rotationAngle: 0)
        card.center = originalPoint
        let cardFrame = card.frame
        reusingView = card
        visibleCards.removeFirst()
        card.removeFromSuperview()
        var newCard: UIView?
        if let totalNumber = dataSource?.numberOfTotalCards(in: self) {
            var newIndex = currentIndex + numberOfVisibleItems
            if newIndex < totalNumber {
                newCard = dataSource?.view(for: self, index: newIndex, reusingView: reusingView)
            } else {
                if showedCyclically {
                    if totalNumber == 1 {
                        newIndex = 0
                    } else {
                        newIndex %= totalNumber
                    }
                    newCard = dataSource?.view(for: self, index: newIndex, reusingView: reusingView)
                }
            }
            if let card = newCard {
                card.frame = cardFrame
                visibleCards.append(card)
            }
            delegate?.cards(self, didRemovedItemAt: currentIndex)
            currentIndex += 1
            layoutCards()
        }
    }
}
