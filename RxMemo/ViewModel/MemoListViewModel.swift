//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import Foundation
import RxCocoa
import RxSwift
/**
 1.의존성을 주입하는 이니셜라이저
 2.바인딩에 사용되는 속성과 메서드
 
 뷰모델은 화면전환과 메모 저장을 모두 처리하는 데 Scene Coordinator와 MemoStrorage를 활용한다.
 뷰모델을 생성하는 시점에 이니셜라이져를 통해서 의존성을 주입해야한다.
 나머지 뷰모델도 마찬가지이다.
 */

class MemoListViewModel: CommonViewModel {
    
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    
    
}
