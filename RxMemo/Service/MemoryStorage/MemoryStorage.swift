//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    /**
     메모리에 메모를 저장하는 클래스,
     
     클래스 외부에서 배열에 직접 접근할 필요가 없기 때문에, private으로 선언했고, 배열은 옵져버블을 통해 외부에 공개
     옵져버블은 배열의 상태가 업데이트되면 새로운 next이벤트를 방출
     그냥 옵져버블 형식으로 만들면 불가능하기 때문에 subject로 만들어야함.
     더미데이터는 BehaivorSubject를 이용
     
     */

    private var list = [
        Memo(content: "Hello RxSwift", insertDate: Date().addingTimeInterval(-10)),
        Memo(content: "Lorem Ipsum", insertDate: Date().addingTimeInterval(-20))
    ]
    
    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)

    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])

    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        sectionModel.items.insert(memo, at: 0)
        store.onNext([sectionModel])

        return Observable.just(memo)
    }

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        return store
    }

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> { //현재 메모가 전달, 컨텐트에는 업데이트된 새로운 내용
        let updated = Memo(original: memo, updatedContent: content)

        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updated, at: index)
        }
        store.onNext([sectionModel])
        return Observable.just(updated) //업데이트된 옵져버블 방출
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> { //리스트 배열에서 메모를 삭제하고 서브젝트에서 새로운 넥스트 이벤트 방출
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
        }
        store.onNext([sectionModel])
        
        return Observable.just(memo)
    }


}
