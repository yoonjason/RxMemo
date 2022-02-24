//
//  CommonViewModel.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/24.
//

import Foundation
import RxSwift
import RxCocoa

class CommonViewModel: NSObject {
    /**
     앱을 구성하는 모든 Scene는 네비게이션 컨트롤러에 임베드 되기 때문에 네비게이션 title이 필요하다
     네비게이션 아이템에 쉽게 바인딩 가능하다.
     */
    let title: Driver<String>
    
    /**
     씬 코디네이터와 저장소를 저장하는 속성
     프로토콜로 선언하여 의존성을 쉽게 수정할 수 있도록한다.
     */
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoStorageType
    
    init(
        title: String,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageType
    ) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
