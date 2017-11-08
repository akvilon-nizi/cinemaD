//
// Created by 1 on 07/11/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxMoya

class FilterConfigurator {

    static let tag: String = "FilterTag"

    var appRouter: AppRouterProtocol!

    var provider: RxMoyaProvider<FoodleTarget>!

    let output: FilterModuleOutput
    let genres: [String]
    let years: [String]
    let filterParameters: FilterParameters
    let isWatched: Bool

    init(output: FilterModuleOutput, genres: [String], years: [String], filterParameters: FilterParameters, isWatched: Bool) {
        self.output = output
        self.years = years
        self.genres = genres
        self.isWatched = isWatched
        self.filterParameters = filterParameters
    }

    func configureModule() -> UIViewController {
        let router = FilterRouter()
        router.appRouter = appRouter

        let presenter = FilterPresenter()
        presenter.router = router
        presenter.output = output

        let interactor = FilterInteractor()
        interactor.output = presenter

        let genresIndex = isWatched ? filterParameters.watchedGenres : filterParameters.willWatchGenresIndex
        let yearsIndex = isWatched ? filterParameters.watchedYears : filterParameters.willWatchYears
        let viewController = FilterViewController(genres: genres, years: years, genresInd: genresIndex, yearsInd: yearsIndex)
        viewController.output = presenter

        presenter.interactor = interactor
        presenter.view = viewController

        return viewController
    }
}
