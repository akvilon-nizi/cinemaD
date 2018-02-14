//
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import Dip
import Moya
import RxMoya

enum Containers {
    case viewControllers
    case managers

    enum ViewControllerType: String, DependencyTagConvertible {
        case systemAlert
    }

    var container: DependencyContainer {
        switch self {
        case .viewControllers:
            return type(of: self).viewControllersContainer
        case .managers:
            return type(of: self).managersContainer
        }
    }

    private static let viewControllersContainer: DependencyContainer = {
        Dip.logLevel = .Errors

        let container = DependencyContainer()

        container.register(tag: ViewControllerType.systemAlert) { (data: AlertControllerData) -> UIViewController in
            let alertController = UIAlertController(title: data.title, message: data.message, preferredStyle: .alert)
            data.actions.forEach {
                alertController.addAction($0)
            }
            return alertController
        }

        container.register(tag: SlidesConfigurator.tag) { () -> UIViewController in
            let configurator = SlidesConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.firstLaunchManager = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: StartConfigurator.tag) { (isError: Bool) -> UIViewController in
            let configurator = StartConfigurator(isError: isError)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            configurator.authTokenManager = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: MainConfigurator.tag) { () -> UIViewController in
            let configurator = MainConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: FilmsConfigurator.tag) { (films: [Film]) -> UIViewController in
            let configurator = FilmsConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            configurator.films = films
            return configurator.configureModule()
        }

        container.register(tag: FilmConfigurator.tag) { (videoID: String, name: String) -> UIViewController in
            let configurator = FilmConfigurator(videoID: videoID, name: name)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: ActorsConfigurator.tag) { (id: String, name: String, role: String, persons: [PersonFromFilm]) -> UIViewController in
            let configurator = ActorsConfigurator(id: id, name: name, role: role, persons: persons)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: KinobaseConfigurator.tag) { () -> UIViewController in
            let configurator = KinobaseConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: RewardsConfigurator.tag) { () -> UIViewController in
            let configurator = RewardsConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            configurator.locationManager = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: MainConfigurator.tag) { () -> UIViewController in
            let configurator = MainConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            configurator.locationManager = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: NewCollectionsConfigurator.tag) { (output: NewCollectionsModuleOutput, id: String, name: String, watched: [Film]) -> UIViewController in
            let configurator = NewCollectionsConfigurator(output: output, id: id, nameCol: name, watched: watched)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: ProfileConfigurator.tag) { (mainView: MainTabView) -> UIViewController in
            let configurator = ProfileConfigurator(mainView)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: FriendsConfigurator.tag) { () -> UIViewController in
            let configurator = FriendsConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: EditingProfileConfigurator.tag) { (
            nameUser: String,
            avatar: String,
            output: EditingProfileModuleOutput
        ) -> UIViewController in
            let configurator = EditingProfileConfigurator((nameUser: nameUser, avatar: avatar, output: output))
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: SettingsConfigurator.tag) { () -> UIViewController in
            let configurator = SettingsConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            configurator.locationManager = try managersContainer.resolve()
            configurator.authTokenManager = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: NewsConfigurator.tag) { (newsID: String) -> UIViewController in
            let configurator = NewsConfigurator(newsID: newsID)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: ReviewsConfigurator.tag) { (film: FullFilm) -> UIViewController in
            let configurator = ReviewsConfigurator(film: film)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: AdminCollectionConfigurator.tag) { (id: String, name: String) -> UIViewController in
            let configurator = AdminCollectionConfigurator(id: id, name: name)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: ChatsConfigurator.tag) { () -> UIViewController in
            let configurator = ChatsConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: TicketsConfigurator.tag) { () -> UIViewController in
            let configurator = TicketsConfigurator()
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        container.register(tag: FilterConfigurator.tag) {(output: FilterModuleOutput,
            genres: [String],
            years: [Int],
            filterParameters: FilterParameters,
            isWatched: Bool
            ) -> UIViewController in
            let configurator = FilterConfigurator(
                output: output,
                genres: genres,
                years: years,
                filterParameters: filterParameters,
                isWatched: isWatched)
            configurator.appRouter = try managersContainer.resolve()
            configurator.provider = try managersContainer.resolve()
            return configurator.configureModule()
        }

        return container
    }()

    private static let managersContainer: DependencyContainer = {
        let container = DependencyContainer()

        container.register {

            try LogoutManagerImplementation(regionManager: container.resolve(),
                                            termsManager: container.resolve(),
                                            authTokenManager: container.resolve()) as LogoutManager
        }

        container.register {

            RegionManagerImplementation(userDefaults: UserDefaults.standard) as RegionManager
        }
        container.register {

            TermsManagerImplementation(userDefaults: UserDefaults.standard) as TermsManager
        }
        container.register {
            NotificationCenter.default
        }
        container.register {
            try LaunchManager(
                moduleCreator: container.resolve(),
                authTokenManager: container.resolve(),
                regionManager: container.resolve(),
                termsManager: container.resolve(),
                firstLaunchManager: container.resolve()
            ) as LaunchManagerProtocol
        }
        container.register {
            LocationManager() as LocationManagerProtocol
        }
        container.register { _ -> AppRouterProtocol in
            let router = try AppRouter(
                application: container.resolve(),
                factory: viewControllersContainer,
                moduleCreator: container.resolve()
            )
            router.dataSource = try container.resolve()
            return router as AppRouterProtocol
        }
        container.register { _ -> AppRouterModuleCreator in
            ModuleCreator(factory: viewControllersContainer) as AppRouterModuleCreator
        }
        container.register {
            UIApplication.shared
        }
        container.register { _ -> AppRouterFlowControllerDataSource in
            let application = try container.resolve() as UIApplication
            // swiftlint:disable:next force_cast
            return application.delegate as! AppRouterFlowControllerDataSource
        }
        container.register {
            AuthTokenManager() as AuthTokenManagerProtocol
        }
        container.register {
            FirstLaunchManager(userDefaults: UserDefaults.standard) as FirstLaunchManagerProtocol
        }
        container.register(tag: AuthTokenMoyaPlugin.tag) {
            AuthTokenMoyaPlugin(authTokenManager: try container.resolve()) as PluginType
        }

        enum NetworkPluginType: Int, DependencyTagConvertible {
            case indicator
        }

        container.register(tag: NetworkPluginType.indicator) { () -> PluginType in
            let application = try container.resolve() as UIApplication
            let networkIndicatorPlugin = NetworkActivityPlugin(networkActivityClosure: {
                switch $0 {
                case .began:
                    application.isNetworkActivityIndicatorVisible = true
                case .ended:
                    application.isNetworkActivityIndicatorVisible = false
                }
            })
            return networkIndicatorPlugin as PluginType
        }

        container.register { _ -> RxMoyaProvider<FoodleTarget> in
            let authTokenManager = try container.resolve() as AuthTokenManagerProtocol
            return RxMoyaProvider<FoodleTarget>(
                endpointClosure: { (target: FoodleTarget) -> Endpoint<FoodleTarget> in
                    /*let endpoint = Endpoint<FoodleTarget>(
                        url: target.baseURL.absoluteString + target.path,
                        sampleResponseClosure: {
                            .networkResponse(401, target.sampleData)
                        },
                        method: target.method,
                        parameters: target.parameters,
                        parameterEncoding: target.parameterEncoding
                    )*/
                    let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
                    var newHTTPHeaderFields: [String: String] = [:]
                    guard target.isRequiredAuth else {
                        log.debug("Auth token not needed")
                        return endpoint
                    }
                    guard let apiToken = authTokenManager.apiToken else {
                        log.warning("Api token not found")
                        return endpoint
                    }
                    newHTTPHeaderFields["Authorization"] = apiToken
                    newHTTPHeaderFields["Content-Type"] = "application/x-www-form-urlencoded"
                    return endpoint.adding(newHTTPHeaderFields: newHTTPHeaderFields)
                },
                stubClosure: { (target: FoodleTarget) -> Moya.StubBehavior in
                    switch target {
                    /*case .restaurants:
                        return .delayed(seconds: 3)*/
                    default:
                        return .never
                    }
                },
                plugins: [
                    NetworkLoggerPlugin(verbose: Configurations.current == .debug),
                    try container.resolve(tag: NetworkPluginType.indicator),
                    try container.resolve(tag: AuthTokenMoyaPlugin.tag)
                ]
            )
        }

        return container
    }()
}
