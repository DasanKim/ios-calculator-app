//
//  OperandFormatter.swift
//  Calculator
//
//  Created by Dasan on 2023/06/14.
//

import Foundation

struct OperandFormatter {
    private let numberFormatter: NumberFormatter
    private let maximumDecimalDigits = 5
    private let maximumOperandDigits = 20 // 연산프로퍼티

    init(operandFormatter: NumberFormatter = NumberFormatter()) {
        self.numberFormatter = operandFormatter
        self.numberFormatter.numberStyle = .decimal
        self.numberFormatter.maximumFractionDigits = maximumDecimalDigits
        self.numberFormatter.maximumIntegerDigits = maximumOperandDigits
    }
    
    func formattingOperand(_ inputedOperand: String, _ currentOperand: String) -> String {
        guard checkOperandLength(inputedOperand, currentOperand),
              checkDecimalLength(inputedOperand, currentOperand) else {
            return currentOperand
        }
        
        if currentOperand.isZero && inputedOperand != "." && inputedOperand != "00" {
            return inputedOperand
        }
        
        if inputedOperand == "." {
            return currentOperand.contains(".") ? currentOperand : currentOperand + inputedOperand
        }
        
        if currentOperand.contains(".") {
            let separatedOperand = currentOperand.components(separatedBy: ".")
            let integerPart = separatedOperand.first ?? "0"
            let decimalPart = separatedOperand.last ?? ""
            let formattingIntegerPart = numberFormatter.string(for: Int(integerPart.withoutDecimalPoint)) ?? "0"
            
            return formattingIntegerPart + "." + decimalPart + inputedOperand
        } else {
            return numberFormatter.string(for: Double(currentOperand.withoutDecimalPoint + inputedOperand)) ?? "0"
        }
    }
    
    func numberToString(for input: Any) -> String? {
        return numberFormatter.string(for: input)
    }
}

// MARK: - Private Method
extension OperandFormatter {
    private func checkOperandLength(_ inputedOperand: String, _ currentOperand: String) -> Bool {
        let number = currentOperand.withoutDecimalPoint + inputedOperand
        return number.count <= maximumOperandDigits
    }
    
    private func checkDecimalLength(_ inputedOperand: String, _ currentOperand: String) -> Bool {
        guard currentOperand.contains(".") else {
            return true
        }
        let decimalPart = currentOperand.components(separatedBy: ".").last ?? ""
        
        return (decimalPart + inputedOperand).count <= maximumDecimalDigits
    }
}