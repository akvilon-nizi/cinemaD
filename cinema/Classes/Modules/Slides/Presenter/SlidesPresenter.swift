//
// Created by DanilaLyahomskiy on 30/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import UIKit

class SlidesPresenter {

    weak var view: SlidesViewInput!
    var interactor: SlidesInteractorInput!
    var router: SlidesRouterInput!
    weak var output: SlidesModuleOutput?
    let slidesArrayInfo: [SlideStruct] = [
        SlideStruct(image: Asset.Slide.slideImageFirst.image, title: L10n.slideFirstTitle, descriprion: L10n.slideFirstDescription),
        SlideStruct(image: Asset.Slide.slideImageSecond.image, title: L10n.slideSecondTitle, descriprion: L10n.slideSecondDescription),
        SlideStruct(image: Asset.Slide.slideImageThird.image, title: L10n.slideThirdTitle, descriprion: L10n.slideThirdDescription)
    ]
}

// MARK: - SlidesViewOutput

extension SlidesPresenter: SlidesViewOutput {

    func viewIsReady() {
        log.verbose("Slides is ready")
    }

    func nextActions() {
        log.verbose("Skip Slides screen")

        interactor.slidesClosed()

        router.openAuth()
    }

    func getSlidesArrayInfo() -> [SlideStruct] {
        return slidesArrayInfo
    }
}

// MARK: - SlidesInteractorOutput

extension SlidesPresenter: SlidesInteractorOutput {

}
