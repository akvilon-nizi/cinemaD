//
// Created by User on 03.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import CoreLocation

enum FoodleTarget {
    case registration(password: String, name: String, phone: String)
    case getTokenFromUid(uid: String, code: String)
    case auth(phone: String, password: String)
    case restore(phone: String)
    case restoreFromUid(uid: String, code: String)
    case sendCode(phone: String)
    case checkCode(phone: String, code: String)
    case films
    case film(filmID: String)
    case filmWatched(filmID: String, rate: Int)
    case filmWillWatch(filmID: String)
    case trailersFilms
    case persons
    case person(personID: String)
    case now
    case recommendations
    case youtubeVideo(videoId: String)

    var isRequiredAuth: Bool {
        switch self {
        case .sendCode, .checkCode:
            return false
        default:
            return true
        }
    }
}

extension FoodleTarget: TargetType {

    var baseURL: URL {
        switch self {
        case .sendCode, .checkCode:
            return Configurations.current.youtubeURL
        default:
            return Configurations.current.apiBaseURL
        }
    }

    var path: String {
        switch self {
        case .registration:
            return "registration"
        case .auth:
            return "login"
        case .sendCode:
            return "auth/send-code"
        case .checkCode:
            return "auth/check-code"
        case .trailersFilms:
            return "trailers"
        case .films:
            return "films"
        case let .film(filmID):
            return "films/\(filmID)"
        case let .filmWatched(filmID, _):
            return "films/\(filmID)/action/watched"
        case let .filmWillWatch(filmID):
            return "films/\(filmID)/action/will_watch"
        case .persons:
            return "persons"
        case let .person(personID):
            return "persons/\(personID)"
        case .now:
            return "films/now"
        case .recommendations:
            return "films/recommendations"
        case .youtubeVideo:
            return "videos"
        case let .getTokenFromUid(uid, _):
            return "registration/\(uid))"
        case .restore:
            return "restore"
        case let .restoreFromUid(uid, _):
            return "restore/\(uid))"
        }
    }

    var method: Moya.Method {
        switch self {
        case  .trailersFilms, .films, .film, .persons, .person, .now, .recommendations, .youtubeVideo:
            return .get
//        case :
//            return .delete
//        case :
//            return .patch
//        case :
//            return .put
        default:
            return .post
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case let .registration(password, name, phone):
            return ["password": password, "phone": phone, "name": name]
        case let .restore(phone):
            return ["phone": phone]
        case let .restoreFromUid(_, code):
            var parameters: [String: Any] = [:]
            parameters["sms_token"] = code
            return parameters
        case let .auth(phone, password):
            return ["password": password, "phone": phone]
        case let .filmWatched(_, rate):
            return ["rate": rate]
        case let .getTokenFromUid(_, code):
            var parameters: [String: Any] = [:]
                parameters["sms_token"] = code
            return parameters
        case let .sendCode(phone):
            return ["phone": phone]
        case let .checkCode(phone, code):
            return ["phone": phone, "code": code]
        case let .youtubeVideo(videoId):
            return ["key": Configurations.googleApi, "part": "snippet", "id": videoId]
        default:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding()
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
//        switch self {
//        case let .uploadData(data):
//        return .upload(.multipart([MultipartFormData(provider: .data(data), name: "body", fileName: "photo.jpg", mimeType: "image/jpeg")]))
//        default:
            return .request
//        }
    }
}

private func loadDataFromBundle(with name: String) -> Data {
    guard let path = Bundle.main.path(forResource: name, ofType: "json"),
          let data = FileManager.default.contents(atPath: path) else {
        fatalError("Example file not found for name: \(name)")
    }
    return data
}
