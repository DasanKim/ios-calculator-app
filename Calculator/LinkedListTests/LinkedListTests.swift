//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by Dasan on 2023/05/30.
//

import XCTest
//import Foundation
@testable import Calculator

final class LinkedListTests: XCTestCase {
    var sut: LinkedList<CalculateItem>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = LinkedList()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_count_조건없이_count를호출할때_count는_0이다() {
        // given
        let expectation = 0
        
        //when
        let result = sut.count
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_count_초기화로_head에_nil을넣었을때_count는_0이다() {
        // given
        sut = LinkedList(head: nil)
        let expectation = 0
        
        // when
        let result = sut.count
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_count_초기화로_head에_Node를넣었을때_count는_1이다() {
        // given
        sut = LinkedList(head: Node(data: 1))
        let expectation = 1
        
        // when
        let result = sut.count
        
        // then
        XCTAssertEqual(result, expectation)
    }
        
    func test_isEmpty_조건없이_isEmpty를호출할때_isEmpty는_true이다() {
        // given, when
        let result = sut.isEmpty
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_isEmpty_초기화로_head에_nil을넣었을때_isEmpty는_true이다() {
        // given
        sut = LinkedList(head: nil)
        
        // when
        let result = sut.isEmpty
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_isEmpty_초기화로_head에_Node를넣었을때_isEmpty는_false이다() {
        // given
        sut = LinkedList(head: Node(data: 1))
        
        // when
        let result = sut.isEmpty
        
        // then
        XCTAssertFalse(result)
    }

    func test_first_조건없이_first를호출할때_first는_nil이다() {
        // given, when
        let result = sut.first
        
        // then
        XCTAssertNil(result)
    }
    
    func test_first_초기화로_head에_data_1를넣고_first를호출하면_first는_1이다() {
        // given
        sut = LinkedList(head: Node(data: 1))
        let expectation = 1
        
        //when
        let result = sut.first as! Int
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_last_조건없이_last를호출할때_last는_nil이다() {
        // given, when
        let result = sut.last
        
        // then
        XCTAssertNil(result)
    }
    
    func test_last_초기화로_head에_data_1를넣고_last를호출하면_last는_1이다() {
        // given
        sut = LinkedList(head: Node(data: 1))
        let expectation = 1
        
        //when
        let result = sut.last as! Int
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_append_노드가없을때_append_1을하면_first와last값이_1로_같다() {
        // given
        sut.append(1)
        
        //when
        let firstResult = sut.first as! Int
        let lastResult = sut.last as! Int
        
        // then
        XCTAssertEqual(firstResult, lastResult)
    }
    
    func test_append_append_1_2_3을하면_first값은_1이다() {
        // given
        sut.append(1)
        sut.append(2)
        sut.append(3)
        let expectation = 1
        
        //when
        let result = sut.first as! Int
        
        // then
        XCTAssertEqual(result, expectation)
    }

    func test_append_append_1_2_3을하면_last값은_3이다() {
        // given
        sut.append(1)
        sut.append(2)
        sut.append(3)
        let expectation = 3
        
        //when
        let result = sut.last as! Int
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_removeFirst_노드가없을때_removeFirst를하면_nil을반환한다() {
        // given, when
        let result = sut.removeFirst()
        
        // then
        XCTAssertNil(result)
    }
    
    func test_removeFirst_append_1을하고_removeFirst를하면_first와last는_nil이다() {
        // given
        sut.append(1)
        
        // when
        let _ = sut.removeFirst()
        
        // then
        XCTAssertNil(sut.first)
        XCTAssertNil(sut.last)
    }
    
    func test_removeFirst_append_1_2_3을하고_removeFirst를하면_1을_반환한다() {
        // given
        sut.append(1)
        sut.append(2)
        sut.append(3)
        let expectation = 1
        
        // when
        let result = sut.removeFirst() as! Int
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_removeFirst_append_1_2_3을하고_removeFirst를하면_first값은_2가된다() {
        // given
        sut.append(1)
        sut.append(2)
        sut.append(3)
        let _ = sut.removeFirst()
        let expectation = 2
        
        // when
        let result = sut.first as! Int
        
        // then
        XCTAssertEqual(result, expectation)
    }
}
