//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol EditProfileViewInput: class {

    func setupInitialState(withProfile profile: Profile)

    func update(profile: Profile)
}

protocol EditProfileViewOutput {

    func viewIsReady()

    func imageWasChosen(image: UIImage)

    func removeAvatarButtonTapped()

    func needToUpdateProfile()

    func saveButtonTapped(name: String, phone: String, email: String)

    func cityButtonTapped()

    func leftButtonTapped()
}
