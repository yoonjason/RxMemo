//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by twave on 2020/08/25.
//  Copyright © 2020 yeongseok. All rights reserved.
//

import Foundation
import RxSwift

protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene : Scene, using style : TransitionStyle, animated : Bool) -> Completable
    
    @discardableResult
    func close(animated : Bool) -> Completable
}
