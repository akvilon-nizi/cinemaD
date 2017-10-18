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
    case persons
    case person(personID: String)
    case now
    case recommendations
    case youtubeVideo(videoId: String)
    case restaurant(restaurantID: Int)
    case product(productID: Int)
    case products(restaurantID: Int, categoryID: Int, count: Int, page: Int)
    case likedProducts(restaurantID: Int, count: Int, page: Int)
    case incrementProductCount(productID: Int)
    case decrementProductCount(productID: Int)
    case restaurants(coordinate: CLLocationCoordinate2D?)
    case cart
    case clearCart
    case cities
    case terms
    case trailersFilms
    case users(id: Int)
    case updateProfile(profile: Profile)
    case updateRegion(cityID: Int)
    case uploadData(data: Data)
    case updateAvatar(id: Int)
    case turnNotifications(enabled: Bool)
    case confirm(code: String)
    case logout
    case removeAvatar
    case orders(count: Int, page: Int)

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
        case .persons:
            return "persons"
        case let .person(personID):
            return "persons/\(personID)"
        case .now:
            return "films/now"
        case .recommendations:
            return "films/recommendations"
        case .restaurants:
            return "restaurants"
        case .youtubeVideo:
            return "videos"
        case let .restaurant(restaurantID):
            return "restaurants/\(restaurantID)"
        case let .getTokenFromUid(uid, _):
            return "registration/\(uid))"
        case .restore:
            return "restore"
        case let .restoreFromUid(uid, _):
            return "restore/\(uid))"
        case .products:
            return "products"
        case let .product(productID):
            return "products/\(productID)"
        case .likedProducts:
            return "products/liked"
        case .incrementProductCount,
             .cart,
             .clearCart:
            return "cart"
        case .decrementProductCount(productID: let productID):
            return "cart/\(productID)"
        case .cities:
            return "cities"
        case .terms:
            return "terms"
        case .users(id: let id):
            return "users/\(id)"
        case .updateProfile,
             .updateRegion,
             .turnNotifications,
             .updateAvatar:
            return "users/0"
        case .uploadData:
            return "upload"
        case .confirm:
            return "users/0/confirm"
        case .logout:
            return "users/0/logout"
        case .removeAvatar:
            return "users/0/avatar"
        case .orders:
            return "orders"
        }
    }

    var method: Moya.Method {
        switch self {
        case .restaurants, .restaurant, .products, .cart, .cities, .terms, .users, .product, .orders, .trailersFilms, .films, .film, .persons, .person, .now, .recommendations, .youtubeVideo:
            return .get
        case .decrementProductCount, .clearCart, .removeAvatar:
            return .delete
        case .updateProfile,
             .updateRegion,
             .updateAvatar,
             .turnNotifications:
            return .patch
        case .logout:
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
        case let .products(restaurantID, categoryID, count, page):
            return ["restaurant_id": restaurantID, "category_id": categoryID, "per-page": count, "page": page]
        case let .likedProducts(restaurantID, count, page):
            return ["restaurant_id": restaurantID, "per-page": count, "page": page]
        case let .incrementProductCount(productID):
            return ["product_id": productID]
        case let .restaurants(coordinate):
            var parameters: [String: Any] = [:]
            if let coord = coordinate {
                parameters["lat"] = coord.latitude
                parameters["long"] = coord.longitude
            }
            return parameters
        case let .updateProfile(profile):

            var parameters: [String: Any] = [:]

            if let region = profile.city {

                parameters["city_id"] = region.id
            }

            parameters["name"] = profile.name
            parameters["phone"] = profile.phone
            parameters["email"] = profile.email

            return parameters
        case let .updateRegion(cityID):
            return ["city_id": cityID]
        case let .turnNotifications(enabled):
            return ["push_notifications": enabled]
        case let .updateAvatar(id):
            return ["avatar_id": id]
        case let .confirm(code):
            return ["code": code]
        case let .orders(count, page):
            return ["per-page": count, "page": page]
        default:
            return nil
        }
    }

    var parameterEncoding: ParameterEncoding {

        switch self {
        case .uploadData(data: _):
            return URLEncoding(destination: .httpBody)
        default:
            return URLEncoding()
        }
    }

    var sampleData: Data {
        switch self {
        case .sendCode:
            return Data()
        case .checkCode:
            return Data()
        case .restaurants:
            return loadDataFromBundle(with: "restaurants")
        default:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case let .uploadData(data):
        return .upload(.multipart([MultipartFormData(provider: .data(data), name: "body", fileName: "photo.jpg", mimeType: "image/jpeg")]))
        default:
            return .request
        }
    }
}

private func loadDataFromBundle(with name: String) -> Data {
    guard let path = Bundle.main.path(forResource: name, ofType: "json"),
          let data = FileManager.default.contents(atPath: path) else {
        fatalError("Example file not found for name: \(name)")
    }
    return data
}
