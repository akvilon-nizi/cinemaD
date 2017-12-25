//
// Created by akvilon-nizi on 04/10/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore
import VKSdkFramework
import AccountKit

class StartViewController: ParentViewController {

    var output: StartViewOutput!

    var accountKit: AKFAccountKit?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.cnmFuturaMedium(size: 24)
        label.textColor = UIColor.cnmGreyColor
        label.text = L10n.startTitleText
        return label
    }()

    let logoImageView = UIImageView(image: Asset.Cinema.start.image)
    let contentView = UIView()

    // MARK: - Life cycle

    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    //let imageView = UIImageView(image: Asset.StartViews.Start.background.image)
        //view.addSubview(imageView.prepareForAutoLayout())

        VKSdk.initialize(withAppId: "6258240").register(self)
        VKSdk.instance().uiDelegate = self

        if accountKit == nil {
            accountKit = AKFAccountKit(responseType: .authorizationCode)
        }

        view.addSubview(contentView.prepareForAutoLayout())
        contentView.leadingAnchor ~= view.leadingAnchor
        contentView.trailingAnchor ~= view.trailingAnchor
        contentView.centerYAnchor ~= view.centerYAnchor
//        contentView.heightAnchor ~= 440

        addTopViews()
        addBottomViews()
        output.viewIsReady()
    }

    private func addTopViews() {

//        let formImageView = UIImageView(image: Asset.Cinema.start.image)
//        logoImageView.addSubview(formImageView.prepareForAutoLayout())
//        formImageView.centerXAnchor ~= logoImageView.centerXAnchor
//        formImageView.centerYAnchor ~= logoImageView.centerYAnchor - 10
//        formImageView.heightAnchor ~= 38
//        formImageView.widthAnchor ~= 43

        contentView.addSubview(titleLabel.prepareForAutoLayout())
        titleLabel.bottomAnchor ~= contentView.centerYAnchor - 30
        titleLabel.centerXAnchor ~= contentView.centerXAnchor

        contentView.addSubview(logoImageView.prepareForAutoLayout())
        logoImageView.bottomAnchor ~= titleLabel.topAnchor - 10
        logoImageView.centerXAnchor ~= contentView.centerXAnchor
        logoImageView.heightAnchor ~= 184
        logoImageView.widthAnchor ~= 130
    }

    private func addBottomViews() {
        let fbButton = UIButton(type: .system).setTitleWithColor(title: L10n.startFacebookText, color: UIColor.cnmFbColor)
        fbButton.addTarget(self, action: #selector(handleTapFbButton), for: .touchUpInside)
        let vkButtom = UIButton(type: .system).setTitleWithColor(title: L10n.startVkontakteText, color: UIColor.cnmVkColor)
        vkButtom.addTarget(self, action: #selector(handleTapVkButton), for: .touchUpInside)
        let regButton = UIButton(type: .system).setTitleWithColor(title: L10n.startRegistrationText, color: UIColor.cnmMainOrange)
        regButton.addTarget(self, action: #selector(handleTapRegButton), for: .touchUpInside)
        let buttonsStackView = createStackView(.vertical, .fill, .fill, 11.0, with: [fbButton, vkButtom, regButton])
        contentView.addSubview(buttonsStackView.prepareForAutoLayout())
        buttonsStackView.centerXAnchor ~= contentView.centerXAnchor
        buttonsStackView.topAnchor ~= contentView.centerYAnchor + 20
        buttonsStackView.bottomAnchor ~= contentView.bottomAnchor

//        let authLabel = UILabel()
//        authLabel.textColor = .cnmGreyTextColor
//        authLabel.font = UIFont.cnmFutura(size: 12)
//        authLabel.text = L10n.startHaveAuthText
//
//        let authButton = UIButton(type: .system)
//        authButton.addTarget(self, action: #selector(handleTapAuthButton), for: .touchUpInside)
//        authButton.setTitle(L10n.startButtonAuthText, for: .normal)
//        authButton.titleLabel?.font = UIFont.cnmFutura(size: 12)
//        authButton.setTitleColor(UIColor.cnmBlueLight, for: .normal)
//
//        let bottomStackView = createStackView(.horizontal, .fill, .fill, 5.0, with: [authLabel, authButton])
//        contentView.addSubview(bottomStackView.prepareForAutoLayout())
//        bottomStackView.centerXAnchor ~= contentView.centerXAnchor
//        bottomStackView.topAnchor ~= buttonsStackView.bottomAnchor + 21
//        bottomStackView.bottomAnchor ~= contentView.bottomAnchor
    }

    // MARK: - Actions
    func handleTapRegButton() {
//        output?.registration()
        if let vc = accountKit?.viewControllerForPhoneLogin() as? AKFViewController {
            prepareLoginViewController(vc)
            // swiftlint:disable:next force_cast
            present(vc as! UIViewController, animated: true, completion: nil)
            vc.delegate = self
        }
    }

    func handleTapAuthButton() {
        output?.auth()
    }

    func handleTapFbButton() {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(readPermissions: [ .publicProfile], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let token):
                print("User cancelled login.")
            }
        }
    }

    func handleTapVkButton() {
        let wakeUpSession = VKSdk.wakeUpSession(nil, complete: { _ in
                VKSdk.forceLogout()
                VKSdk.authorize([])
            }
        )
    }

    func prepareLoginViewController(_ loginViewController: AKFViewController) {

        loginViewController.delegate = self
        loginViewController.setAdvancedUIManager(nil)

        //Costumize the theme
        let theme: AKFTheme = AKFTheme.default()
        theme.headerBackgroundColor = .green
        theme.headerTextColor = .green
        theme.iconColor = .green
        theme.inputTextColor = .green
        theme.statusBarStyle = .default
        theme.textColor = .green
        theme.titleColor = .green
        loginViewController.setTheme(theme)

    }
}

// MARK: - StartViewInput

extension StartViewController: StartViewInput {

    func setupInitialState() {

    }

    func showNetworkError(message: String) {
        let statusBarAlertManager = StatusBarAlertManager.sharedInstance
        statusBarAlertManager.setStatusBarAlert(with: message, with: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            statusBarAlertManager.clear()
        }
    }

    func getError() {
        showAlert(message: L10n.alertCinemaNetworkErrror)
    }
}


extension StartViewController: VKSdkDelegate {
    /**
     Notifies about access error. For example, this may occurs when user rejected app permissions through VK.com
     */
    public func vkSdkUserAuthorizationFailed() {
        print()
    }

    /**
     Notifies about authorization was completed, and returns authorization result with new token or error.

     @param result contains new token or error, retrieved after VK authorization.
     */
    public func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            print()
//            self.loginService.loginByVK(with: result.token.accessToken!, deviceId: result.token.userId!)
        }
        print()
    }
    func vkSdkShouldPresentViewController(controller: UIViewController) {
        print()
    }
}

extension StartViewController: VKSdkUIDelegate {
    public    func vkSdkTokenHasExpired(expiredToken: VKAccessToken) {
        print()
    }
    //    func vkSdkUserDeniedAccess(authorizationError: VKError) {
    public func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print()
    }
    public func vkSdkShouldPresent(_ controller: UIViewController!) {
        if !VKSdk.vkAppMayExists() {
            present(controller, animated: true, completion: nil)
        }
    }
}

// MARK: - AKFViewControllerDelegate

extension StartViewController: AKFViewControllerDelegate {

    func viewController(_ viewController: UIViewController!, didCompleteLoginWithAuthorizationCode code: String!, state: String!) {
        output.getAuthCode(code)
    }
    func viewController(viewController: UIViewController!, didFailWithError error: NSError!) {
        print("error \(error)")
    }
    func viewController(_ viewController: UIViewController!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("did complete login with access token \(accessToken.tokenString) state \(state)")
    }
}
