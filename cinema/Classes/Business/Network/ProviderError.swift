//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import RxMoya
import RxSwift
import ObjectMapper

struct ProviderError: Swift.Error {

    var code: Int
    var message: String
    var fullMessage: String
    var status: Int

    func debugDescription() -> String {
        return "code:\(code) message:\(message) fullMessage:\(fullMessage) status:\(status)"
    }
}

extension ProviderError {

    init(message: String, status: Int) {
        self.code = 0
        self.message = message
        self.fullMessage = message
        self.status = status
    }
}

extension RxMoyaProvider {

    private func map(_ error: Swift.Error) -> ProviderError {
        switch error {
        case let moyaError as MoyaError:
            return mapMoyaError(moyaError)
        case let mapperError as MapError:
            return ProviderError(message: mapperError.description, status: 0)
        default:
            return ProviderError(message: "unrecognized error", status: 0)
        }
    }

    private func mapMoyaError(_ error: MoyaError) -> ProviderError {
        switch error {

        case .statusCode(let request):
            guard let jsonError = try? JSONSerialization.jsonObject(with: request.data, options: .allowFragments),
                  let json = jsonError as? [String: Any] else {
                return ProviderError(message: "json error", status: request.statusCode)
            }

            guard let serverError = try? Mapper<ErrorResponse>(context: nil).map(JSONObject: json) else {
                return ProviderError(message: "server error", status: request.statusCode)
            }

            return ProviderError(
                code: 0,
                message: serverError.message,
                fullMessage: configureFullMessage(for: serverError.message, fields: serverError.fields),
                status: request.statusCode
            )

        case .imageMapping, .jsonMapping, .stringMapping:
            return ProviderError(message: "mapping error", status: 0)

        case .underlying:
            let internalError = error as NSError
            return ProviderError(
                code: internalError.code,
                message: internalError.localizedDescription,
                fullMessage: internalError.localizedDescription,
                status: internalError.code
            )

        case .requestMapping(let message):
            return ProviderError(message: message, status: 0)
        }
    }

    private func configureFullMessage(for message: String, fields: [ErrorField]) -> String {
        var messages: [String] = []

        messages.append(message)
        messages.append(contentsOf: fields.map {
            $0.message
        })

        messages = messages.filter {
            !$0.isEmpty
        }

        return messages.joined(separator: " ")
    }

    func requestModel<Model: ImmutableMappable>(_ token: Target) -> Observable<Model> {
        return request(token)
            .filterSuccessfulStatusCodes()
            .mapObject(Model.self)
            .catchError { error in
                Observable.error(self.map(error))
            }
    }

    func requestArray<Model: ImmutableMappable>(_ token: Target) -> Observable<[Model]> {
        return request(token)
            .filterSuccessfulStatusCodes()
            .mapArray(Model.self)
            .catchError { error in
                Observable.error(self.map(error))
            }
    }
}
