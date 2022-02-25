//
//  CoreDataStorage.swift
//  RxMemo
//
//  Created by Bradley.yoon on 2022/02/25.
//
import CoreData
import Foundation

import RxCoreData
import RxSwift

/**
 
 CoreDataStorage 클래스를 선언하고, MemoStorageType 프로토콜을 채택
 
 */
class CoreDataStorage: MemoStorageType {

    let modelName: String

    init(
        modelName: String
    ) {
        self.modelName = modelName
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }


    /**
     RxCoreData 활용
     */
    @discardableResult
    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        do {
            _ = try mainContext.rx.update(memo) //있으면 업데이트, 없으면 추가
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        /**
         옵져버블을 리턴하고, 옵져버블이 방출하는 요소의 형식은 첫번째 파라미터로 전달한 형식의 배열
         Observable<[MemoSectionModel]> 을 방출하므로 map으로 변환시킨다.
         */
        return mainContext.rx.entities(
            Memo.self,
            sortDescriptors: [NSSortDescriptor(key: "insertDate", ascending: false)])
            .map { results in [MemoSectionModel(model: 0, items: results)] }
    }

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        /**
         구조체와 상수로 이루어진  메모 인스턴스와 변경된 내용이 파라미터
         변경된 내용을 기반으로 새로운 인스턴스를 만들어 방출
         */
        let updated = Memo(original: memo, updatedContent: content)
        do {
            _ = try mainContext.rx.update(updated)
            return Observable.just(updated)
        } catch {
            return Observable.error(error)
        }
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        do {
            try mainContext.rx.delete(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }




}


