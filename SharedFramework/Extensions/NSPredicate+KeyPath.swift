//
//  NSSortDescriptor+KeyPath.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation


// Trying some stuff from https://github.com/kishikawakatsumi/Kuery/blob/master/Sources/Kuery/ManagedObjectProperty.swift
public protocol Property {
    var _object: AnyObject { get }
}

public protocol EquatableProperty: Property {}
public protocol ComparableProperty: EquatableProperty {}

extension Bool: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int16: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int32: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int64: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Int: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Float: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Double: ComparableProperty {
    public var _object: AnyObject { return NSNumber(value: self) }
}
extension Date: ComparableProperty {
    public var _object: AnyObject { return self as NSDate }
}
extension String: ComparableProperty {
    public var _object: AnyObject { return self as NSString }
}
extension NSPredicate {
    
    public enum PredicateOperator: String {
        case equals = "=="
        case equalsIgnoreCase = "==[c]"
        case greaterThan = ">"
        case greaterThanOrEqualTo = ">="
        case lessThan = "<"
        case lessThanOrEqualTo = "<="
    }
    
    
    public convenience init<Root, Property: ComparableProperty>(keyPath: KeyPath<Root, Property?>,
                                  operatorType: PredicateOperator = .equals,
                                  value: Property) {
        self.init(format: "%K \(operatorType.rawValue) %@",
                  argumentArray: [
                    keyPath._kvcKeyPathString! as NSString,
                    value._object
                  ])
    }
    
    public convenience init<Root, Property: ComparableProperty>(keyPath: KeyPath<Root, Property>,
                                                               operatorType: PredicateOperator = .equals,
                                                               value: Property) {
        self.init(format: "%K \(operatorType.rawValue) %@",
                  argumentArray: [
                    keyPath._kvcKeyPathString! as NSString,
                    value._object
                  ])
    }
}
