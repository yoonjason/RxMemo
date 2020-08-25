//
//  TransitionModel.swift
//  RxMemo
//
//  Created by twave on 2020/08/25.
//  Copyright © 2020 yeongseok. All rights reserved.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError : Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
