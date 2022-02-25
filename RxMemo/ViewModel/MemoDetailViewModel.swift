//
//  MemoDetailViewModel.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/23.
//

import Foundation

import Action
import RxCocoa
import RxSwift
import UIKit

class MemoDetailViewModel: CommonViewModel {

    /**
     이전 Scene에서 전달된 메모가 저장된다.
     */
    var memo: Memo

    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    /**
     메모 내용을 테이블 뷰에 표시하므로, 옵져버블과 바인딩한다.
     메모 보기 화면에서 편집하고, 다시 보기화면으로 돌아오면 편집한 내용이 반영되어야하므로, 문자열 배열을 가진 BehaviorSubject로 선언
     */
    var contents: BehaviorSubject<[String]>

    init(
        memo: Memo,
        title: String,
        sceneCoordinator: SceneCoordinatorType,
        storage: MemoStorageType
    ) {
        self.memo = memo
        contents = BehaviorSubject<[String]>(value: [
            memo.content, formatter.string(from: memo.insertDate)
        ])

        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }

    lazy var popAction = CocoaAction { [unowned self] in
        return self.sceneCoordinator.close(animated: true)
            .asObservable()
            .map { _ in }
    }

    /**
     ComposeViewModel로 전달하기 위한 update메서드
     */
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            /**
             메모를 편집하고 저장버튼을 누르면 액션이 실행되고, 새로운 내용을 subjet로 전달한다.
             */
            self.storage.update(memo: memo, content: input)
                .do(onNext: {
                self.memo = $0
            })
                .map { [$0.content, self.formatter.string(from: $0.insertDate)] }
                .bind(onNext: { self.contents.onNext($0) })
                .disposed(by: self.rx.disposeBag)

            return Observable.empty()
        }
    }

    /**
     composeView로 가기위한 메서드
     */
    func makeEditAction() -> CocoaAction {
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(
                title: "메모 편집",
                content: self.memo.content,
                sceneCoordinator: self.sceneCoordinator,
                storage: self.storage,
                saveAction: self.performUpdate(memo: self.memo)
            )

            let composeScene = Scene.compose(composeViewModel)

            return self.sceneCoordinator.transition(
                to: composeScene,
                using: .modal,
                animated: true)
                .asObservable()
                .map { _ in }
        }
    }

    func shareAction() -> CocoaAction {
        return CocoaAction { input in
            print("#@#@# \(input)")
            let detatilViewModel = MemoDetailViewModel(
                memo: self.memo,
                title: "메모 공유",
                sceneCoordinator: self.sceneCoordinator,
                storage: self.storage)
            let detailScene = Scene.share(detatilViewModel)
            return self.sceneCoordinator.transition(to: detailScene, using: .share, animated: true)
                .asObservable()
                .map { _ in }
        }
    }

    func makeDeleteAction() -> CocoaAction {
        return Action { input in
            self.storage.delete(memo: self.memo)
            return self.sceneCoordinator.close(animated: true)
                .asObservable()
                .map { _ in }
        }
    }
}
