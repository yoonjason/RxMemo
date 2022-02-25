//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import Foundation

import Action
import RxCocoa
import RxSwift


class MemoListViewModel: CommonViewModel {

    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }

    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in

            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                let composeViewModel = MemoComposeViewModel(
                    title: "새 메모",
                    sceneCoordinator: self.sceneCoordinator,
                    storage: self.storage,
                    saveAction: self.performUpdate(memo: memo),
                    cancelAction: self.performCancel(memo: memo)
                )
                let composeScene = Scene.compose(composeViewModel)

                return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
            }
        }
    }

    /**
     
     Action은 항상 2개의 파라미터를 받는 데, Action<입력, 출력>으로 구성된다.
     메모를 전달하면 input파라미터로 전달
     옵져버블이 방출하는 형식은 Void
     update 메서드가 리턴하는 옵져버블은 편집된 메모를 방출한다.
     */
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }

    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }


    /**
     뷰 모델을 만들고, Scene을 만들고 Scene Coordinator의 Transition을 호출해서 화면 전환시킨다.
     */
    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in

            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)

            let detatilScene = Scene.detail(detailViewModel)

            return self.sceneCoordinator.transition(to: detatilScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()



}
