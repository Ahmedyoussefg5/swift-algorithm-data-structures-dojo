//
//  SimpleDequeue.swift
//  SwiftAlgorithmsAndDataStructuresDojo
//
//  Created by Prearo, Andrea on 3/17/17.
//
//

import Foundation

// MARK: - SimpleDequeue
/*
 `SimpleDequeue` is using an `Array` as the underlying mechanism for storing data.
 Because of this, the `pop` and `pushFront` operations are not optimized:
 - The `push` and `popBack` operationd require constant time O(1), as we are just appending
   to the array or removing the last element.
 - The `pop` and `pushFront` operations, instead, require linear time O(n) because `Array`
   needs to rearrange the entire array after removing the first item and when inserting an
   element anywhere but at the end.
 */
public final class SimpleDequeue<T> {
    fileprivate var items: [T] = []
    fileprivate var maxSize: Int = Int.max

    public var count: Int {
        return items.count
    }

    public var front: T? {
        return items.first
    }
    
    public var back: T? {
        return items.last
    }

    public var isEmpty: Bool {
        return items.count == 0
    }

    public convenience init(maxSize: Int) {
        self.init()
        self.maxSize = maxSize
    }

    public convenience init(array: Array<T>) {
        self.init()

        for element in array {
            try? self.push(element)
        }
    }

    public func push(_ item: T) throws {
        if items.count == maxSize {
            throw DequeueError.outOfSpace
        }
        items.append(item)
    }

    public func pushFront(_ item: T) throws {
        if items.count == maxSize {
            throw DequeueError.outOfSpace
        }
        items.insert(item, at: 0)
    }

    public func pop() -> T? {
        if isEmpty {
            return nil
        }
        return items.removeFirst()
    }

    public func popBack() -> T? {
        if isEmpty {
            return nil
        }
        return items.removeLast()
    }

    public func clear() {
        items = []
    }
}

// MARK: - SimpleDequeue + CustomStringConvertible
extension SimpleDequeue: CustomStringConvertible {
    public var description: String {
        var string = "["
        _ = (0..<items.count).map {
            string += "\(items[$0])"
            if $0 < items.count - 1 {
                string += ", "
            }
        }
        return string + "]"
    }
}

// MARK: - SimpleDequeue + Sequence
extension SimpleDequeue: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        return AnyIterator {
            return self.pop()
        }
    }
}

// MARK: - SimpleDequeue + ExpressibleByArrayLiteral
extension SimpleDequeue: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()

        for element in elements {
            try? self.push(element)
        }
    }
}

// MARK: - SimpleDequeue to Array<T>
extension SimpleDequeue {
    var array: [T] {
        return items
    }
}
