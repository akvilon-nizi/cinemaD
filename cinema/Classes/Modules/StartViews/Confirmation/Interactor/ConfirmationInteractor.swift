//
// Created by akvilon-nizi on 05/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation
import RxMoya
import RxSwift

class ConfirmationInteractor {

    fileprivate let disposeBag = DisposeBag()
    var provider: RxMoyaProvider<FoodleTarget>!
    weak var output: ConfirmationInteractorOutput!
    var authTokenManager: AuthTokenManagerProtocol!
    var isRestore: Bool!

}

// MARK: - ConfirmationInteractorInput

extension ConfirmationInteractor: ConfirmationInteractorInput {
    func getToken(code: String, uid: String) {
//        if isRestore {
////        provider.requestModel(.getTokenFromUid(uid: uid, code: code))
////            .subscribe { [unowned self] (response: Event<RegistrationUIDResponse>) in
////                switch response {
////                case let .next(model):
////                    print()
//////                    self.output.getUid(uid: model.uid, phone: phoneIn)
////                case let .error(error as ProviderError):
////                    let token = "eyJhbGciOiJIUzI1NiIsImlhdCI6MTUwNzY4NDI4MCwiZXhwIjoxNTA3NzcwNjgwfQ.eyJ0eXBlIjoiYWNjZXNzX3Rva2VuIiwiZGV2aWNlIjoid2ViIiwiaWQiOiI2NWM1MzcwMS1mZTRmLTRiM2MtOGY3OS0xNjA1MTA2ZDJhOWEiLCJjb3VwbGVfaWQiOiI0NjgyZGU5ZC0yOGY1LTRlZDUtYjY3YS02YWM4ZTUyMWY4YWMifQ.cwN4rybvOj0FxboU97__ybU_oZU7KMRw3WDAqZMviXE"
////                    self.authTokenManager.save(apiToken: token)
//////                    self.output.getError()
////                default:
////                    break
////                }
////            }
////            .addDisposableTo(disposeBag)
//        } else {
        var request = URLRequest(url: URL(string: String(format: "https://cinemad.pr-solution.ru/api/registration/%@", uid))!)
        if isRestore {
            request = URLRequest(url: URL(string: String(format: "https://cinemad.pr-solution.ru/api/restore/%@", uid))!)
        }
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dic = ["sms_token": code]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted) else {
            return
            // return or break
        }
            request.httpBody = jsonData

//            request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                self?.output?.faulireGetToken()
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")

            }
            guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: String] else {
                self?.output?.faulireGetToken()
                return
            }
            if let token: String = json?["access_token"] {
                self?.authTokenManager.save(apiToken: token)
                self?.output?.successGetToken()
            } else {
                self?.output?.faulireGetToken()
            }

        }
        task.resume()
//        }
    }
    func getCode(uid: String) {
    }
}
