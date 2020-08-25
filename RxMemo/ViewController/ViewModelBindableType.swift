//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by twave on 2020/08/25.
//  Copyright © 2020 yeongseok. All rights reserved.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType // 아무 타입이나 가능하다잉
    
    var viewModel : ViewModelType! { get set }
    func bindViewModel()
    
}

extension ViewModelBindableType where Self : UIViewController {
    mutating func bind(viewModel : Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
