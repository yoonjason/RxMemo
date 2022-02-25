//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import Foundation
import RxSwift

protocol MemoStorageType {

    @discardableResult //필요없을 수도 있다.
    func createMemo(content: String) -> Observable<Memo>

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]>

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
