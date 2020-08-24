//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by twave on 2020/08/24.
//  Copyright © 2020 yeongseok. All rights reserved.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    @discardableResult
    func createMemo(content : String) -> Observable<Memo>
    
    @discardableResult
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo : Memo, content : String) -> Observable<Memo>

    @discardableResult
    func delete(memo : Memo) -> Observable<Memo>
}
