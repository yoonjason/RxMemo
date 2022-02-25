//
//  Memo.swift
//  RxMemo
//
//  Created by yoon on 2022/02/23.
//

import Foundation
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
