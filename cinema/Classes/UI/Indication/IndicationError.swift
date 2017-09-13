//
// Created by Александр Масленников on 22.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import UIKit

protocol IndicationErrorInput {

    weak var output: IndicationErrorOutput? { get set }

    func update(message: String)
}

protocol IndicationErrorOutput: class {

    func reloadPressed(in view: UIView)
}
