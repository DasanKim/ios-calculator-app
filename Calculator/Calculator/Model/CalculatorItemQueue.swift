//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by Yena on 2023/05/30.
//

import Foundation

protocol CalculateItem {
    
}

extension Int:CalculateItem {
    
}

extension String:CalculateItem {
    
}

extension Double:CalculateItem {
    
}

struct CalculatorItemQueue<T: CalculateItem> {
    //var queue: [T] = [T]()
    var queue: LinkedList = LinkedList<T>()
    
    var count: Int {
        return queue.count
    }
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(_ element: T) {
        queue.append(element)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty == false {
            return queue.removeFirst()
        }
        return nil
    }
}
