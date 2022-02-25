//
//  TransitionModel.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/23.
//

import Foundation

enum TransitionStyle {
    case root //첫번째 화면
    case push //네비게이션 스택에 푸시
    case modal //모달화면
    case share
}

enum TransitionError: Error {
    case navigationControllerMissing //네비게이션 컨트롤러가 없을 때 방출하는 에러
    case cannotPop //네비게이션 스택에 들어가있는 컨트롤러를 팝할 수 없을 때
    case unknown //에러의 종류를 알 수 없을 때
}




