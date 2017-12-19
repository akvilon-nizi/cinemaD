//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class MainInteractor {

    weak var output: MainInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()
    var mainData = MainData()

}

// MARK: - MainInteractorInput

extension MainInteractor: MainInteractorInput {

    func getData() {
        getProfile()
    }

    func getProfile() {
        provider.requestModel(.profile)
            .subscribe { [unowned self] (response: Event<ProfileModel>) in
                switch response {
                case let .next(model):
                    self.mainData.profile = model
                    self.getTrailers()
                case let .error(error as ProviderError):
                    if error.status == 403 {
                        self.output.tokenError()
                    } else {
                        self.output.getError()
                    }
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func postLocation(lat: Double, log: Double) {
        provider.requestModel(.postAdwardsGeo(lat: lat, log: log))
            .subscribe { [unowned self] (response: Event<GeoResponse>) in
                switch response {
                case let .next(model):
                    print()
                case let .error(error as ProviderError):
                    print()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getTrailers() {
        provider.requestModel(.trailersFilms)
            .subscribe { [unowned self] (response: Event<TrailersResponse>) in
                switch response {
                case let .next(model):
                    self.mainData.trailers = model.trailers
                    self.getNow() 
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getNow() {
        provider.requestModel(.now)
            .subscribe { [unowned self] (response: Event<NowResponse>) in
                switch response {
                case let .next(model):
                    self.mainData.now = model.now
                    self.getRecommendations()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getRecommendations() {
        provider.requestModel(.recommendations)
            .subscribe { [unowned self] (response: Event<RecommendationsResponse>) in
                switch response {
                case let .next(model):
                    self.mainData.recomend = model.recommendations
                    self.getNews()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getNews() {
        provider.requestModel(.news)
            .subscribe { [unowned self] (response: Event<NewsResponse>) in
                switch response {
                case let .next(model):
                    self.mainData.news = model.news
                    self.output.getData(mainData: self.mainData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getNewsWithFilters(filters: [String]) {
        provider.requestModel(.newsFiltred(filters: filters))
            .subscribe { [unowned self] (response: Event<NewsResponse>) in
                switch response {
                case let .next(model):
                    self.mainData.news = model.news
                    self.output.getNews(mainData: self.mainData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
