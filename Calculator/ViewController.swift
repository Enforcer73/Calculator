//
//  ViewController.swift
//  Calculator
//
//  Created by Musafir on 19.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLable: UILabel!
    var stillTyping = false
    var firstOperand: Double = 0
    var secondOperant: Double = 0
    var operationSign: String = ""
    var dotKey = false
    
    var currentInput: Double {
        get {
            return Double(displayLable.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray [1] == "0" {
                displayLable.text = "\(valueArray[0])"
            } else {
                displayLable.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    
    @IBAction func digitsKey(_ sender: UIButton) {
        let digits = sender.currentTitle!
        
        if stillTyping {
            if displayLable.text!.count < 9 {
                displayLable.text = displayLable.text! + digits
            }
        } else {
            displayLable.text = digits
            stillTyping = true
        }
    }
    
    @IBAction func operationsKey(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotKey = false
    }
        
    func mathOperation(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperant)
        stillTyping = false
    }
    
    @IBAction func equalityKey(_ sender: UIButton) {
        if stillTyping {
            secondOperant = currentInput
        }
        
        dotKey = false
        
        switch operationSign {
        case "+":
            mathOperation {$0 + $1}
        case "−":
            mathOperation {$0 - $1}
        case "×":
            mathOperation {$0 * $1}
        case "÷":
            mathOperation {$0 / $1}
        default: break
        }
    }
    
    @IBAction func resetKey(_ sender: UIButton) {
        firstOperand = 0
        secondOperant = 0
        currentInput = 0
        displayLable.text = "0"
        stillTyping = false
        operationSign = ""
        dotKey = false
    }
    
    @IBAction func plusMinusKey(_ sender: UIButton) {
        if displayLable.text == "0" {
            currentInput = +currentInput
        } else {
            currentInput = -currentInput
        }
    }
    
    @IBAction func percentKey(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            currentInput = firstOperand * (currentInput / 100)
        }
    }
    
    @IBAction func dotKey(_ sender: UIButton) {
        if stillTyping && !dotKey {
            displayLable.text = displayLable.text! + "."
            dotKey = true
        } else if !stillTyping && !dotKey {
            displayLable.text = "0."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }

}

