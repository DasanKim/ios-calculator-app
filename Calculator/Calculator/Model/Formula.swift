//
//  Formula.swift
//  Calculator
//
//  Created by Dasan on 2023/06/02.
//

struct Formula {
    var operands: CalculatorItemQueue<Double>
    var operators: CalculatorItemQueue<Operator>

    mutating func result() throws -> Double {
        guard var resultValue = operands.dequeue() else {
            throw CalculatorError.NoValue
        }
        
        while operators.isEmpty == false {
            guard let rightValue = operands.dequeue(),
                  let currentOperator = operators.dequeue() else {
                throw CalculatorError.NoValue
            }
            resultValue = try currentOperator.calculate(lhs: resultValue, rhs: rightValue)
        }
    
        return resultValue
    }
}
