//
//  EditProfilePhotoImporterDelegate.swift
//  foodle
//
//  Created by incetro on 04/10/16.
//  Copyright © 2016 Incetro. All rights reserved.
//

import UIKit

// MARK: - EditProfilePhotoImporterDelegate

protocol EditProfilePhotoImporterDelegate: class {

    func cameraAccessDenied()

    func galleryAccessDenied()

    func didGetImage(image: UIImage)
}
