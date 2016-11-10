//
//  DefaultSection.swift
//  RxDataSourcesExample
//
//  Created by Lukasz Mroz on 08.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Foundation
import RxDataSources

public struct DefaultSection: AnimatableSectionModelType {
    
    public typealias Item = DefaultItem
    public typealias Identity = String
    
    var header: String
    var storedItems: [Item] {
        didSet {
            updated = Date()
        }
    }
    var updated: Date
    
    init(header: String, items: [Item], updated: Date) {
        self.header = header
        self.storedItems = items
        self.updated = updated
    }
    
    public init(original: DefaultSection, items: [Item]) {
        self = original
        self.storedItems = items
    }
    
    public var identity: Identity {
        return header
    }
    
    public var items: [Item] {
        return storedItems
    }
}

public struct DefaultItem {
    let title: String
    let dateChanged: Date
}

extension DefaultItem: IdentifiableType, Equatable {
    public typealias Identity = String
    
    public var identity: Identity {
        return title
    }
}

public func == (lhs: DefaultItem, rhs: DefaultItem) -> Bool {
    return lhs.title == rhs.title && (lhs.dateChanged == rhs.dateChanged)
}
