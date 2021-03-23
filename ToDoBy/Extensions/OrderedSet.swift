//
//  OrderedSet.swift
//  ToDoBy
//
//  Created by School on 3/17/21.
//

import Foundation

struct OrderedSet<Element: Hashable & Codable> {
    typealias Element = Element
    public init() { }
    var elements: [Element] = []
    var set: Set<Element> = []
}

extension OrderedSet: MutableCollection {
    
    subscript(index: Index) -> Element {
        get { elements[index] }
        set {
            guard let newMember = set.update(with: newValue) else { return }
            elements[index] = newMember
        }
    }
}

extension OrderedSet: RandomAccessCollection {
    
    typealias Index = Int
    typealias Indices = Range<Int>
    
    typealias SubSequence = Slice<OrderedSet<Element>>
    typealias Iterator = IndexingIterator<Self>
    
    // Generic subscript to support `PartialRangeThrough`, `PartialRangeUpTo`, `PartialRangeFrom` and `FullRange`
    subscript<R: RangeExpression>(range: R) -> SubSequence where Index == R.Bound { .init(elements[range]) }
    
    var endIndex: Index { elements.endIndex }
    var startIndex: Index { elements.startIndex }

    func formIndex(after i: inout Index) { elements.formIndex(after: &i) }
    
    var isEmpty: Bool { elements.isEmpty }

    @discardableResult
    mutating func append(_ newElement: Element) -> Bool { insert(newElement).inserted }
}

extension OrderedSet: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.elements.elementsEqual(rhs.elements)
    }
}

extension OrderedSet: SetAlgebra {
    mutating func insert(_ newMember: Element) -> (inserted: Bool, memberAfterInsert: Element) {
        let insertion = set.insert(newMember)
        if insertion.inserted {
            elements.append(newMember)
        }
        return insertion
    }
    mutating func remove(_ member: Element) -> Element? {
        if let index = elements.firstIndex(of: member) {
            elements.remove(at: index)
            return set.remove(member)
        }
        return nil
    }
    mutating func update(with newMember: Element) -> Element? {
        if let index = elements.firstIndex(of: newMember) {
            elements[index] = newMember
            return set.update(with: newMember)
        } else {
            elements.append(newMember)
            set.insert(newMember)
            return nil
        }
    }
    
    func union(_ other: Self) -> Self {
        var orderedSet = self
        orderedSet.formUnion(other)
        return orderedSet
    }
    func intersection(_ other: Self) -> Self {
        var orderedSet = self
        orderedSet.formIntersection(other)
        return orderedSet
    }
    func symmetricDifference(_ other: Self) -> Self {
        var orderedSet = self
        orderedSet.formSymmetricDifference(other)
        return orderedSet
    }
    
    mutating func formUnion(_ other: Self) {
        other.forEach { append($0) }
    }
    mutating func formIntersection(_ other: Self) {
        self = .init(filter { other.contains($0) })
    }
    mutating func formSymmetricDifference(_ other: Self) {
        self = .init(filter { !other.set.contains($0) } + other.filter { !set.contains($0) })
    }
}

extension OrderedSet: ExpressibleByArrayLiteral {
    init(arrayLiteral: Element...) {
        self.init()
        for element in arrayLiteral {
            self.append(element)
        }
    }
}

extension OrderedSet: CustomStringConvertible {
    var description: String { .init(describing: elements) }
}

extension OrderedSet: AdditiveArithmetic {
    static var zero: Self { .init() }
    static func + (lhs: Self, rhs: Self) -> Self { lhs.union(rhs) }
    static func - (lhs: Self, rhs: Self) -> Self { lhs.subtracting(rhs)}
    static func += (lhs: inout Self, rhs: Self) { lhs.formUnion(rhs) }
    static func -= (lhs: inout Self, rhs: Self) { lhs.subtract(rhs) }
}

extension OrderedSet: RangeReplaceableCollection {
    init<S>(_ elements: S) where S: Sequence, S.Element == Element {
        elements.forEach { set.insert($0).inserted ? self.elements.append($0) : ()}
    }
    
    mutating func replaceSubrange<C: Collection, R: RangeExpression>(_ subrange: R, with newElements: C) where Element == C.Element, C.Element: Hashable, Index == R.Bound {
        elements[subrange].forEach({ set.remove($0) })
        elements.removeSubrange(subrange)
        newElements.forEach { set.insert($0).inserted ? elements.append($0) : ()}
    }
}

extension OrderedSet: Encodable, Decodable {}
