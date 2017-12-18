//
// Created by Danila Lyahomskiy on 05/12/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

struct FriendsData {
    var friends: [Creator] = []
    var recomendaions: [Creator] = []
    var news: [FriendsNews] = []
    var newsView: [FriendsNewsForView] = []
}

class FriendsInteractor {

    weak var output: FriendsInteractorOutput!
    var provider: RxMoyaProvider<FoodleTarget>!
    fileprivate let disposeBag = DisposeBag()
    var friendsData = FriendsData()
}

// MARK: - FriendsInteractorInput

extension FriendsInteractor: FriendsInteractorInput {
    func getData() {
        provider.requestModel(.friends)
            .subscribe { [unowned self] (response: Event<FriendsResponse>) in
                switch response {
                case let .next(model):
                    self.friendsData.friends = model.friends
                    self.getRecomendations()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func getRecomendations() {
        provider.requestModel(.friendsRecommendation)
            .subscribe { [unowned self] (response: Event<FriendsResponse>) in
                switch response {
                case let .next(model):
                    self.friendsData.recomendaions = model.friends
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
        provider.requestModel(.friendsNews)
            .subscribe { [unowned self] (response: Event<FriendsNewsResponse>) in
                switch response {
                case let .next(model):
                    self.friendsData.news = model.friends
                    self.output.getData(data: self.friendsData)
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    func addFriend(id: String) {
        provider.requestModel(.putFriends(id: id))
            .subscribe { [unowned self] (response: Event<Creator>) in
                switch response {
                case let .next(model):
                    self.output.addedFriend()
                case let .error(error as ProviderError):
                    self.output.getError()
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
}
