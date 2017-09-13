//
// Created by incetro on 26/08/2017.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol EditProfileInteractorInput {

    func obtainProfile()

    func updateProfile(_ profile: Profile)

    func uploadAvatar(image: UIImage)

    func removeAvatar()
}

protocol EditProfileInteractorOutput: class {

    func updateProfileSuccess(profile: Profile)
    func updateProfileFailure(errorMessage: String)

    func obtainProfileSuccess(profile: Profile)
    func obtainProfileFailure(errorMessage: String)

    func uploadAvatarSuccess(profile: Profile)
    func uploadAvatarFailure(errorMessage: String)

    func removeAvatarSuccess(profile: Profile)
    func removeAvatarFailure(errorMessage: String)
}
