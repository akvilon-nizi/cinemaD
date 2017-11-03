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
        getTrailers()
    }

    func getTrailers() {
        provider.requestModel(.trailersFilms)
            .subscribe { [unowned self] (response: Event<TrailersResponse>) in
                switch response {
                case let .next(model):
                    self.mainData.trailers = model.trailers
//                    for idVideo in model.trailers {
//                        if let url = URL(string: idVideo),
//                            url.absoluteString.contains("youtube.com/embed/") {
//
//                            let path = (url.path as NSString).replacingOccurrences(of: "/embed/", with: "")
//                            if path != "" {
//                                
//                            }
//                        }
//                    }
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
                    self.output.getData(mainData: self.mainData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
