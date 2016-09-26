//
//  ViewController.swift
//  Calculator
//
//  Created by 林东杰 on 8/15/16.
//  Copyright © 2016 Joey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Constants
    
    // MARK: - Variables
    fileprivate var userIsInTheMiddleOfTyping = false
    
    // MARK: - Properties
    @IBOutlet weak var display: UILabel!
    
    // MARK: - Life Cycle
    
    // MARK: - TableView Data Source
    
    // MARK: - TableView Delegate
    
    // MARK: - Custom Delegate
    
    // MARK: - Event Response
    
    // MARK: - Private Methods
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    
    fileprivate var brain: CalculatorBrain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
//        if let matchematicalSymbol = sender.currentTitle {
//            userIsInTheMiddleOfTyping = false
//            if matchematicalSymbol == "♊︎" {
//                displayValue = M_PI
//            } else if matchematicalSymbol == "✓" {
//                displayValue = sqrt(displayValue)
//            }
//        }
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        userIsInTheMiddleOfTyping = false
        if let matchicalSymbol = sender.currentTitle {
            brain.performOperation(matchicalSymbol)
        }
        displayValue = brain.result
    }
    
    // MARK: - Navigation
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

