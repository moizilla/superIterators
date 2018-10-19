//
//  ViewController.swift
//  MoreTesting
//
//  Created by Olmedo Pina, Moises on 4/5/18.
//  Copyright © 2018 Olmedo, Moises. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //let array = [1,3,[5,6],[7],[9,[1,2]],12] as [Any]
        let m = MySequence(elements: [1,[[2,[45,6,7,8]],56,5],3,4])
        //let m = MySequence(elements: [1,[2,3],4])
        //let m = [12,3,4]
        for element in m {
            print(element)
        }
    }
    override func didReceiveMemoryWarning() {
        //dd
    }
}

class MySequence<T>: Sequence {
    var elements = [T]()
    init(elements: [T]) {
        self.elements = elements
    }
    
    func makeIterator() -> MyIterator<T> {
        return MyIterator(elements: elements)
    }
}

class MyIterator<T>: IteratorProtocol {
    
    var storage: LinkedList<T>!
    var current: Node<T>?
    init(elements: [T]) {
        let root = arrayToLinkedList(array: elements, append: nil)!
        self.storage = LinkedList(head: root)
        self.current = root
    }
    
    func arrayToLinkedList(array: [T], append: Node<T>?) -> Node<T>? {
        var root: Node<T>?
        var tmp: Node<T>?
        var last: Node<T>?
        var c=0
        while c < array.count {
            if tmp == nil {
                tmp = Node(value: array[c])
                if root == nil {
                    root = tmp
                }
                if last != nil {
                    last?.next = tmp
                }
            }
            last = tmp
            tmp = tmp?.next
            if c == array.count-1 {
                last?.next = append
            }
            c = c + 1
        }
        return root
    }
    //[1,[[2,[45,6,7,8]],56,5],3,4]
    func next() -> T? {
        guard let _ = current else {
            return nil
        }
        guard let tmp = current else { return nil }
        if let array = current?.value as? Array<T> {
            let newNode = arrayToLinkedList(array: array, append: current?.next)
            current = newNode
            return next()
        } else {
            current = tmp.next
        }
        return tmp.value
    }
    
    typealias Element = T
}

class Node<T> {
    var value: T
    var next: Node?
 
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    var head: Node<T>
    
    init(head: Node<T>) {
        self.head = head
    }
}
