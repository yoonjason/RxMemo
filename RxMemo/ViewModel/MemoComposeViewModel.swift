//
//  MemoComposeViewModel.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/23.
//

import Foundation
import Action
import RxCocoa
import RxSwift

/**
 //MVVM패턴은 ViewController에 ViewModel을 속성으로 추가한다.
 ViewModel과 View를 바인딩한다.

 */

class MemoComposeViewModel: CommonViewModel {
    /**
     새로운 메모를 추가할 때는 nil이 저장되고, 메모를 편집할 때는 편집할 메모가 저장된다.
     */
    private let content: String?
    
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    /**
     저장과 취소 2가지 액션을 구현한다.
     */
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(
        title: String,
        content: String? = nil,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageType,
        saveAction: Action<String, Void>?  = nil,
        cancelAction: CocoaAction? = nil
    ) {
        self.content = content
        
        /**
         Action을 받는 Parameter는 Optional로 선언되어있고, 기본값은 nil이다.
         saveAction에 전달된 action을 그대로 전달하지않고, 한 번더 래핑한다.
         saveAction에 action이 전달되면, action을 전달하며 화면을 닫는다.
         action이 전달되지 않으면 nil이므로 액션은 실행되지않고 화면을 닫고 끝낸다.
         */
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
