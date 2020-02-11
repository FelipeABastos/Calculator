//
//  ViewController.swift
//  Calculator
//
//  Created by Felipe Amorim Bastos on 06/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import UIKit

enum Operation: String {
    
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Null = "Null"
}

class CalculatorViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
//    var numbersArray: Array<Result> = []
    
    @IBOutlet var txtName: UITextField?
    @IBOutlet var lblCount: UILabel?
    
    @IBOutlet var btnAdd: UIButton?
    @IBOutlet var btnSubtract: UIButton?
    @IBOutlet var btnDivide: UIButton?
    @IBOutlet var btnMultiply: UIButton?
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation:Operation =  .Null
    
    //-----------------------------------------------------------------------
    //    MARK: UIViewController
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCount?.text = "0"
        
        if let placeholder = txtName?.placeholder {
            txtName?.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    //-----------------------------------------------------------------------
    //    MARK: Custom methods
    //-----------------------------------------------------------------------
    
    @IBAction func saveCount() {
        
        let savedVC = storyboard?.instantiateViewController(identifier: "SavesView") as! SavesViewController
        
        let dic = ["name": txtName?.text ?? "",
                   "result": lblCount?.text ?? ""]
        
        if var numbersDictionary = UserDefaults.standard.value(forKey: "results") as? Array<Dictionary<String,String>> {
            
            numbersDictionary.append(dic)
            UserDefaults.standard.set(numbersDictionary, forKey: "results")
            UserDefaults.standard.synchronize()
        }else{
            UserDefaults.standard.set([dic], forKey: "results")
        }
        
        txtName?.text = ""
        self.present(savedVC, animated: true, completion: nil)
    }
    
    @IBAction func goToSavedCounts() {
        
        let savedVC = storyboard?.instantiateViewController(identifier: "SavesView") as! SavesViewController
        
        self.present(savedVC, animated: true, completion: nil)
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 8 {
        runningNumber += "\(sender.tag)"
        lblCount?.text = runningNumber
            
            buttonsPressed()
            
        }
    }
    
    @IBAction func allClearPressed(_ sender: UIButton) {
        
        runningNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = .Null
        lblCount?.text = "0"
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        
        if runningNumber.count <= 7 {
        runningNumber += "."
        lblCount?.text = runningNumber
        }
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        operation(operation: currentOperation)
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        
        btnAdd?.backgroundColor = UIColor.white
        btnAdd?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        operation(operation: .Add)
        
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func subtractPressed(_ sender: UIButton) {
        operation(operation: .Subtract)
        
        btnSubtract?.backgroundColor = UIColor.white
        btnSubtract?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        operation(operation: .Multiply)
        
        btnMultiply?.backgroundColor = UIColor.white
        btnMultiply?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    @IBAction func dividePressed(_ sender: UIButton) {
        operation(operation: .Divide)
        
        btnDivide?.backgroundColor = UIColor.white
        btnDivide?.setTitleColor(UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0), for: UIControl.State.normal)
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    func operation(operation: Operation) {
        
        if currentOperation != .Null {
            
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Add {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }else if currentOperation == .Subtract {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }else if currentOperation == .Multiply {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if currentOperation == .Divide {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                
                lblCount?.text = result
            }
            currentOperation = operation
            
        }else{
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func buttonsPressed() {
        
        UIView.animate(withDuration: 0.5) {
            self.btnAdd?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnAdd?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnDivide?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnDivide?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnMultiply?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnMultiply?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.btnSubtract?.backgroundColor = UIColor(red:1.00, green:0.62, blue:0.10, alpha:1.0)
            self.btnSubtract?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
}

