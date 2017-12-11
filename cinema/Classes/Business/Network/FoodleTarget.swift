//
// Created by User on 03.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Moya
import CoreLocation
import Alamofire
import UIKit

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
    case filmWatchedPost(query: String, genres: [String], years: [Int])
    case filmWillWatchPost(query: String, genres: [String], years: [Int])
    case filmWatchedDelete(filmID: String)
    case filmWillWatchDelete(filmID: String)
    case trailersFilms
    case persons
    case person(personID: String)
    case now
    case recommendations
    case youtubeVideo(videoId: String)
    case meFilmWatched
    case meFilmWillWatched
    case getCollections
    case putCollections(name: String)
    case patchCollections(idCol:String, name: String, filmsID: [String])
    case deleteFilm(idFilm: String, idCollections: String)
    case putFilm(idFilm: String, idCollections: String)
    case deleteCollections(idCollections: String)
    case getFilmsFromCollections(idCollections: String)
    case news
    case newsFiltred(filters: [String])
    case newsInfo(newsID: String)
    case newsComments(newsID: String)
    case putNewsComment(newsID: String, message: String)
    case editeProfile(image: UIImage?, name: String, oldPassword: String, newPassword: String)
    case profile
    case review(filmID: String)
    case putReview(filmID: String, name: String, description: String)
    case adwards
    case deleteReview(id: String)
    case deleteComment(id: String)
    case getAdminCollections

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
        case .filmWatchedPost:
            return "me/watched"
        case .filmWillWatchPost:
            return "me/will_watch"
        case let .filmWatchedDelete(filmID):
            return "films/\(filmID)/action/watched"
        case let .filmWillWatchDelete(filmID):
            return "films/\(filmID)/action/will_watch"
        case .meFilmWatched:
            return "me/watched"
        case .meFilmWillWatched:
            return "me/will_watch"
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
        case .getCollections:
            return "me/collections"
        case .getAdminCollections:
            return "me/collections"
        case .putCollections:
            return "me/collections"
        case let .deleteFilm(idFilm, _):
            return "films/\(idFilm)/user_collection"
        case let .putFilm(idFilm, _):
            return "films/\(idFilm)/user_collection"
        case let .deleteCollections(idCollections):
            return "me/collections/\(idCollections)"
        case let .getFilmsFromCollections(idCollections):
            return "me/collections/\(idCollections)"
        case let .patchCollections(idCol, _, _) :
            return "me/collections/\(idCol)"
        case .news:
            return "news"
        case .newsFiltred:
            return "news"
        case let .newsInfo(newsID):
            return "news/\(newsID)"
        case let .newsComments(newsID):
            return "news/\(newsID)/comments"
        case let .putNewsComment(newsID, _):
            return "news/\(newsID)/comments"
        case .editeProfile:
            return "me"
        case .profile:
            return "me"
        case let .review(filmID):
            return "films/\(filmID)/review"
        case let .putReview(filmID, _, _):
            return "films/\(filmID)/review"
        case .adwards:
            return "me/awards"
        case let .deleteReview(id):
            return "reviews/\(id)"
        case let .deleteComment(id):
            return "comments/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case  .trailersFilms, .films, .film, .persons, .person, .now, .recommendations, .youtubeVideo, .meFilmWatched, .meFilmWillWatched, .getCollections, .getFilmsFromCollections, .news, .newsInfo, .newsComments, .profile, .review, .adwards, .getAdminCollections:
            return .get
        case .deleteFilm, .deleteCollections, .filmWatchedDelete, .filmWillWatchDelete, .deleteComment, .deleteReview:
            return .delete
        case .patchCollections, .editeProfile:
            return .patch
        case .putCollections, .putFilm, .putNewsComment, .putReview:
            return .put
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
        case let .putCollections(name):
            return ["name": name]
        case let .deleteFilm(_, idCollections):
            var parameters: [String: Any] = [:]
            parameters["id"] = idCollections
            return parameters
        case let .putFilm(_, idCollections):
           return ["id": idCollections]
        case let .filmWatchedPost(query, genres, years):
            var parameters: [String: Any] = [:]
            if !query.isEmpty {
                parameters["query"] = query
            }
            if !genres.isEmpty {
                parameters["genre"] = genres
            }
            if !years.isEmpty {
                parameters["year"] = years
            }
            return parameters
        case let .filmWillWatchPost(query, genres, years):
            var parameters: [String: Any] = [:]
            parameters["query"] = query
            if !genres.isEmpty {
            parameters["genre"] = genres
            }
            if !years.isEmpty {
            parameters["year"] = years
            }
            return parameters
        case let .patchCollections(_, name, filmsID):
            var parameters: [String: Any] = [:]
            parameters["name"] = name
            parameters["film_ids"] = filmsID
            return parameters
        case let .newsFiltred(filters):
            var parameters: [String: Any] = [:]
            parameters["filter"] = filters
            return parameters
        case let .putNewsComment(_, message):
            return ["description": message]
        case let .putReview(_, name, description):
            var parameters: [String: Any] = [:]
            parameters["name"] = name
            parameters["description"] = description
            return parameters
        case let .editeProfile(_, name, oldPassword, newPassword):
            var parameters: [String: Any] = [:]
            parameters["name"] = name
            if oldPassword.count >= 1 {
                parameters["old_password"] = oldPassword
            }
            if newPassword.count >= 1 {
                parameters["password"] = newPassword
            }
            //parameters["description"] = description
            return parameters
        default:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        case  .filmWatchedPost, .filmWillWatchPost, .patchCollections, .newsFiltred, .auth:
            return JsonArrayEncoding.default
        default:
            return URLEncoding(destination: .queryString)
        }
    }
    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .editeProfile(image, _, _, _):
            if let newImage = image {
                if let data: Data = UIImagePNGRepresentation(newImage) {
                    return .upload(.multipart([MultipartFormData(provider: .data(data), name: "image", fileName: "photo.jpg", mimeType: "image/jpeg")]))
                } else if let data: Data = UIImageJPEGRepresentation(newImage, 1.0) {
                    return .upload(.multipart([MultipartFormData(provider: .data(data), name: "image", fileName: "photo.jpg", mimeType: "image/jpeg")]))
                }
            }
            return .request
        default:
            return .request
        }
    }
}

struct JsonArrayEncoding: Moya.ParameterEncoding {
    public static var `default`: JsonArrayEncoding { return JsonArrayEncoding() }

    /// Creates a URL request by encoding parameters and applying them onto an existing request.
    ///
    /// - parameter urlRequest: The request to have parameters applied.
    /// - parameter parameters: The parameters to apply.
    ///
    /// - throws: An `AFError.parameterEncodingFailed` error if encoding fails.
    ///
    /// - returns: The encoded request.
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
        if let dic = parameters {
            let json = try JSONSerialization.data(withJSONObject: dic, options: JSONSerialization.WritingOptions.prettyPrinted)
            req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            req.httpBody = json
        }
        return req
    }

}

private func loadDataFromBundle(with name: String) -> Data {
    guard let path = Bundle.main.path(forResource: name, ofType: "json"),
          let data = FileManager.default.contents(atPath: path) else {
        fatalError("Example file not found for name: \(name)")
    }
    return data
}
