//
//  AppDelegate.swift
//  cinema
//
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit
import RxSwift
import Dip
import Fabric
import Crashlytics
import FacebookCore
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var rootFlowController: FlowControllerProtocol?
    var firstLaunchManager: LaunchManagerProtocol?
    fileprivate let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        let window = UIWindow(frame: UIScreen.main.bounds)
        do {
            let launchManager = try Containers.managers.container.resolve() as LaunchManagerProtocol
            launchManager.instantiateRootController(in: window)
                .subscribe(onNext: { [unowned self] element in
                    self.rootFlowController = element
                })
                .addDisposableTo(disposeBag)
            self.firstLaunchManager = launchManager
        } catch {
            log.error("initial view controller is not resolved, error = \(error)")
            window.rootViewController = UIViewController()
        }
        window.makeKeyAndVisible()
        self.window = window
        Fabric.with([Crashlytics.self])

        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
            statusBar.backgroundColor = UIColor.white
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state.
        // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or
        // when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks.
        // Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information
        // to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state;
        // here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive.
        // If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return SDKApplicationDelegate.shared.application(application,
//                                                         open: url,
//                                                         sourceApplication: sourceApplication,
//                                                         annotation: annotation)
//    }

//    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        return SDKApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
//    }

    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return true
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // swiftlint:disable:next force_cast
        VKSdk.processOpen(url, fromApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!)
        return SDKApplicationDelegate.shared.application(app, open: url, options: options)
    }

    func application(application: UIApplication, openURL url: NSURL, options: [String: AnyObject]) {
        print()
    }

    func open(_ url: URL, options: [String : Any] = [:],
              completionHandler completion: ((Bool) -> Swift.Void)? = nil) {
        print("APPDELEGATE: open url \(url) with completionHandler")
        completion?(false)
    }
}

extension AppDelegate: AppRouterFlowControllerDataSource {
    func flowControllerForTransition() -> FlowControllerProtocol? {
        return rootFlowController
    }
}
