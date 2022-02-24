//
//  SceneCoordinator.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/24.
//

import Foundation
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {
    
    private let bag = DisposeBag()
    
    /**
     씬 코디네이터는 화면전환을 처리하기 때문에, 윈도우 인스턴스와 현재 화면에 표시되어있는 씬을 가지고 있어야한다.
     */
    private var window: UIWindow
    private var currentVC: UIViewController
    
    init(
        window: UIWindow
    ){
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        /**
         화면 전환 결과를 방출할 subject
         - 화면 전환의 성공과 실패만 방출한다. 엘리먼트의 타입을 Never, next이벤트를 방출할 필요가 없다.
         - 처음부터 Completable 생성해도 되지만 create연산자로 만들어야하고, closure 내부에서 구현해야하기 때문에, 코드가 복잡해 질 수 있다.
         */
        let subject = PublishSubject<Never>() //
        
        /**
         씬을 생성해서 상수에 저장한다.
         - Scene 열거형에서 구현
         - 실제로 Scene을 만든다.
         */
        let target = scene.instantiate()
        
        
        /**
         실제 화면 전환 처리
         */
        switch style {
        case .root:
            //윈도우에서 rootViewController를 바꿔준다.
            currentVC = target
            window.rootViewController = target
            
            subject.onCompleted()
           
        case .push: //네비게이션 컨트롤러에 임베드되어있을 때 의미가 있음
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.pushViewController(target, animated: animated)
            currentVC = target
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target
        }
        return subject.asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self]  completable in
            /**
             현재 씬이 모달 방식으로 되어있다면, dismiss
             */
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    //현재 뷰 컨트롤러를 교체해준다.
                    self.currentVC = presentingVC
                    completable(.completed)
                }
            }
            /**
             현재 씬이 네비게이션 스택에 푸시되어있다면 현재 씬을 팝한다.
             팝을 못 할 경우 에러이벤트를 방출하고 종료한다.
             */
            else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            }
            else {
                completable(.error(TransitionError.unknown))
            }
            return Disposables.create()
        }
        
    }
    
    
}
