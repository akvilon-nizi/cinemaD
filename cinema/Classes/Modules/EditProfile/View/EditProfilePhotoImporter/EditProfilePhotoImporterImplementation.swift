//
//  EditProfilePhotoImporterImplementation.swift
//  Coffee
//
//  Created by incetro on 04/10/16.
//  Copyright © 2016 Incetro. All rights reserved.
//

import UIKit
import Photos
import AVFoundation

// MARK: - EditProfilePhotoImporterImplementation

class EditProfilePhotoImporterImplementation: NSObject {

    weak var delegate: EditProfilePhotoImporterDelegate?

    func createControllerForImportPhotoFromCamera(in viewController: UIViewController) -> UIImagePickerController? {

        if UIImagePickerController.isSourceTypeAvailable(.camera) == false {

            return nil
        }

        let cameraController = UIImagePickerController()

        cameraController.delegate = self
        cameraController.sourceType    = .camera
        cameraController.allowsEditing = false

        cameraController.cameraCaptureMode = .photo

        return cameraController
    }

    func createControllerForImportPhotoFromGallery(in viewController: UIViewController) -> UIImagePickerController? {

        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {

            return nil
        }

        let galleryController = UIImagePickerController()

        galleryController.delegate = self
        galleryController.sourceType    = .photoLibrary
        galleryController.allowsEditing = false

        return galleryController
    }

    fileprivate func checkGalleryPermissions() {

        let status = PHPhotoLibrary.authorizationStatus()

        if status == .authorized {

            self.presentGallery()

        } else if status == .denied {

            self.delegate?.galleryAccessDenied()

        } else if status == .notDetermined {

            PHPhotoLibrary.requestAuthorization { newStatus in

                if newStatus == PHAuthorizationStatus.authorized {

                    self.presentGallery()
                }
            }
        }
    }

    fileprivate func checkCameraPermissions() {

        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)

        if status == .authorized {

            self.presentCamera()

        } else if status == .denied {

            self.delegate?.cameraAccessDenied()

        } else {

            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted: Bool) -> Void in

                if granted == true {

                    self.presentCamera()
                }
            })
        }
    }

    fileprivate func presentCamera() {

        if let controller = delegate as? UIViewController {

            if let cameraController = createControllerForImportPhotoFromCamera(in: controller) {

                controller.present(cameraController, animated: true, completion: nil)
            }
        }
    }

    fileprivate func presentGallery() {

        if let controller = delegate as? UIViewController {

            if let cameraController = createControllerForImportPhotoFromGallery(in: controller) {

                controller.present(cameraController, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - EditProfilePhotoImporter

extension EditProfilePhotoImporterImplementation: EditProfilePhotoImporter {

    func openCamera() {

        checkCameraPermissions()
    }

    func openGallery() {

        checkGalleryPermissions()
    }
}

extension EditProfilePhotoImporterImplementation: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {

            (delegate as? UIViewController)?.dismiss(animated: true) {

                self.delegate?.didGetImage(image: image)
            }
        }
    }
}

extension EditProfilePhotoImporterImplementation: UINavigationControllerDelegate {

}
