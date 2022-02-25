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
           _ = try mainContext.rx.update(memo)
            return Observable.just(memo)
        } catch {
            return Observable.error(error)
        }
    }

    @discardableResult
    func memoList() -> Observable<[MemoSectionModel]> {
        <#code#>
    }

    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo> {
        <#code#>
    }

    @discardableResult
    func delete(memo: Memo) -> Observable<Memo> {
        <#code#>
    }




}


