//
//  SceneCoordinatorType.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/24.
//

import Foundation
import RxSwift

/**
 
 프로토콜을 선언하고 씬 코디네이터가 공통적으로 구현해야하는 멤버를 선언한다.
 두 메서드 모두 리턴형이 Completable 구독자를 추가하고 화면 전환이 완료된 후에 원하는 작업을 구현할 수 있다.
 */
protocol SceneCoordinatorType {
    
    /**
     
     새로운 씬을 표시하고, 대상씬과 트랜지션 스타일, 애니메이션 플래그를 전달한다.
     */
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated:Bool) -> Completable
    
    /**
     
     현재 씬을 닫고 이전 씬으로 돌아간다.
     */
    @discardableResult
    func close(animated: Bool) -> Completable
    
    /**
     
     */
}
