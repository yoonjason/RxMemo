//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/23.
//

import UIKit

/**
 뷰 모델의 타입은 뷰 컨트롤러에 따라서 달라지기 때문에, 프로토콜을 제네릭 프로토콜로 선언해야한다.
 
 */

protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel() //바인딩에 필요한 메서드
}


extension ViewModelBindableType where Self: UIViewController {
    /**
        뷰컨트롤러에 추가된 뷰모델 속성에 파라미터로 전달된 실제 뷰모델을 저장하고 바인드 뷰모델 메서드를 호출한다.
     */
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel() //이렇게하면 뷰컨트롤러에서 바인드 뷰모델 메서드를 호출할 필요가 없기 때문에 코드가 단순해진다.
    }
}

