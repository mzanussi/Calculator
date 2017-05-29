//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Michael Zanussi on 5/29/17.
//  Copyright © 2017 Michael Zanussi. All rights reserved.
//

import Foundation

func changeSign(operand: Double) -> Double {
    return -operand
}

struct CalculatorBrain {
    
    private var accumulator: Double?
    
    private enum Operation {
        case constant(Double)   // associated value
        case unaryOperation((Double) -> Double) // another associated value
    }

    private var operations: Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "±": Operation.unaryOperation(changeSign)
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            }
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {    // computed property
        get {
            return accumulator
        }
    }
    
}
