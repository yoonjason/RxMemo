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
    let memo: Memo
    
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
    
}
