//
//  Memo.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//
import CoreData
import Foundation
import RxCoreData
import RxDataSources

struct Memo: Equatable, IdentifiableType {
    var content: String
    var insertDate: Date
    var identity: String

    init(
        content: String,
        insertDate: Date = Date()
    ) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }

    init(
        original: Memo,
        updatedContent: String
    ) {
        self = original
        self.content = updatedContent
    }

}

extension Memo: Persistable {
    static var entityName: String { //entity의 이름을 리턴
        return "Memo"
    }

    static var primaryAttributeName: String {
        return "identity"
    }

    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        insertDate = entity.value(forKey: "insertDate") as! Date
        identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }

    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(insertDate, forKey: "insertDate")
        entity.setValue("\(insertDate.timeIntervalSinceReferenceDate)", forKey: "identity")

        do {
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }

}
