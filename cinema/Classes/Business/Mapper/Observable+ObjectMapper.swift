//
// Created by Александр Масленников on 03.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import RxSwift
import Moya
import ObjectMapper

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension ObservableType where E == Response {

    /// Maps data received from the signal into an object which implements the Mappable protocol and returns the result back.
    /// If the conversion fails, the signal errors.
    func mapObject<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            Observable.just(try response.mapObject(T.self, context: context))
        }
    }

    /// Maps data received from the signal into an array of objects which implement the Mappable protocol and returns the result back.
    /// If the conversion fails, the signal errors.
    func mapArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            Observable.just(try response.mapArray(T.self, context: context))
        }
    }

}

// MARK: - ImmutableMappable

extension ObservableType where E == Response {

    /// Maps data received from the signal into an object which implements the ImmutableMappable protocol and returns the result back.
    /// If the conversion fails, the signal errors.
    func mapObject<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            Observable.just(try response.mapObject(T.self, context: context))
        }
    }

    /// Maps data received from the signal into an array of objects which implement the ImmutableMappable protocol and returns the result back.
    /// If the conversion fails, the signal errors.
    func mapArray<T: ImmutableMappable>(_ type: T.Type, context: MapContext? = nil) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            Observable.just(try response.mapArray(T.self, context: context))
        }
    }

}
