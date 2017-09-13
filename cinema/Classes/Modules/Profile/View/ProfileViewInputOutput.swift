//
// Created by incetro on 25/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import Foundation

protocol ProfileViewInput: class {

    func setupInitialState()

    func updateProfile(_ profile: Profile)

    func updateCards(_ cards: [Card])
}

protocol ProfileViewOutput {

    func viewIsReady()

    func needUpdateProfile()

    func notificationsWasSwitched(enabled: Bool)

    func editButtonTapped()

    func exitButtonTapped()

    func addCardButtonTapped()

    func cardButtonTapped(card: Card)

    func leftButtonTapped()
}
