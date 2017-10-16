//
//  TermsManager.swift
//  cinema
//
//  Created by incetro on 25/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import Foundation

// MARK: - TermsManager

protocol TermsManager {

    func setConfirmed()

    func clear()

    var confirmed: Bool { get }
}
