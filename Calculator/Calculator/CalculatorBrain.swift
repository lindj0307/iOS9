//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 林东杰 on 8/23/16.
//  Copyright © 2016 Joey. All rights reserved.
//

import Foundation

func multiply(op1:Double,op2:Double) -> Double {
    return op1 * op2
}


class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> = [
        "𝛑": Operation.Constant(M_PI),
        "pi": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "=": Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        /*
        switch symbol {
        case "♊︎":
            accumulator = M_PI
        case "✓":
            accumulator = sqrt(accumulator)
        default:
            break
        }
        if let constant = operations[symbol] {
            accumulator = constant
        }
         */
        
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation (let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function,firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double) -> Double
        var firstOperand: Double
        
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }

    
}