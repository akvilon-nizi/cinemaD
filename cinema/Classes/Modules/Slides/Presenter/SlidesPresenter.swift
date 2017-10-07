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
        SlideStruct(image: Asset.Slide.slideImageFirst.image,
                    title: L10n.slide1TitleText,
                    descriprion: L10n.slide1DescriptionText, mainView: Slide1View()),
        SlideStruct(image: Asset.Slide.slideImageSecond.image,
                    title: L10n.slide2TitleText,
                    descriprion: L10n.slide2DescriptionText, mainView: Slide2View()),
        SlideStruct(image: Asset.Slide.slideImageThird.image,
                    title: L10n.slide3TitleText,
                    descriprion: L10n.slide3DescriptionText, mainView: Slide3View())
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
