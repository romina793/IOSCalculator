//
//  HomeViewController.swift
//  IOS-Calculator
//
//  Created by Romina Pozzuto on 02/08/2020.
//  Copyright © 2020 Romina Pozzuto. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: OUTLET
    
    //Result
    @IBOutlet weak var resultLabel: UILabel!
    
    //Numbers
    @IBOutlet weak var numberZero: UIButton!
    @IBOutlet weak var numberOne: UIButton!
    @IBOutlet weak var numberTwo: UIButton!
    @IBOutlet weak var numberThree: UIButton!
    @IBOutlet weak var numberFour: UIButton!
    @IBOutlet weak var numberFive: UIButton!
    @IBOutlet weak var numberSix: UIButton!
    @IBOutlet weak var numberSeven: UIButton!
    @IBOutlet weak var numberEight: UIButton!
    @IBOutlet weak var numberNine: UIButton!
    @IBOutlet weak var numberDecimal: UIButton!
    
    //Operators
    @IBOutlet weak var operatorAC: UIButton!
    @IBOutlet weak var operatorPluMin: UIButton!
    @IBOutlet weak var operatorPercent: UIButton!
    @IBOutlet weak var operatorResult: UIButton!
    @IBOutlet weak var operatorAddition: UIButton!
    @IBOutlet weak var operatorSustraction: UIButton!
    @IBOutlet weak var operatorMultiplication: UIButton!
    @IBOutlet weak var operatorDivision: UIButton!
    
    
    // MARK: Variables
    
    private var total: Double = 0 // Total
    private var temp: Double = 0 // Valor por pantalla
    private var operating: Bool = false // Indicar si se ha seleccionado un operador
    private var decimal: Bool = false // Indicar si el valor es decimal
    private var operation: OperationType = .none
    
    // MARK: Constantes
    private let kDecimalSeparator = Locale.current.decimalSeparator!
    private let kMaxLenght = 9
    private let kMaxValue: Double = 999999999
    private let kMinValue: Double = 0.00000001

    private enum OperationType{
        case none, addition, sustraction, multiplication, division, percent
    }
    
    // Formateo de valores auxiliares
    private let auxFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = ""
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    // Formato de valores por pantalla por defecto
    private let printFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        let locale = Locale.current
        formatter.groupingSeparator = locale.groupingSeparator
        formatter.decimalSeparator = locale.decimalSeparator
        formatter.numberStyle = .decimal
        formatter.maximumIntegerDigits = 9
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8
        return formatter
    }()
    
    // Formateo de valores por pantalla en formato científico
    private let printScientificFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .scientific
        formatter.minimumFractionDigits = 3
        formatter.exponentSymbol = "e"
        return formatter
    }()
    
    // MARK: - Inicialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleRoundButton()
        numberDecimal.setTitle(kDecimalSeparator, for: .normal)
    }
    
    
    func setStyleRoundButton(){
        
        // Numbers
        numberZero.round()
        numberOne.round()
        numberTwo.round()
        numberThree.round()
        numberFour.round()
        numberFive.round()
        numberSix.round()
        numberSeven.round()
        numberEight.round()
        numberNine.round()
        
        // Operators
        operatorAC.round()
        operatorPluMin.round()
        operatorPercent.round()
        operatorResult.round()
        operatorAddition.round()
        operatorSustraction.round()
        operatorMultiplication.round()
        operatorDivision.round()
    }
    
    
    
    // MARK: Button Action
    
    @IBAction func operationACAction(_ sender: UIButton) {
        clear()
        sender.shine()
    }
    
    @IBAction func operationPlusMinAction(_ sender: UIButton) {
        temp = temp * (-1)
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        sender.shine()

    }
    
    @IBAction func operatorPercentAction(_ sender: UIButton) {
        
        if operation != .percent{
            result()
        }
        operating = true
        operation = .percent
        result()
        sender.shine()

    }
    @IBAction func operatorResultAction(_ sender: UIButton) {
        result()
        sender.shine()

    }
    
    @IBAction func operatorAdditionAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .addition
        sender.shine()

    }
    
    @IBAction func operatorSustractionAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .sustraction
        sender.shine()

    }
    
    @IBAction func operatorMultiplicationAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .multiplication
        sender.shine()

    }
    
    @IBAction func operatorDivisionAction(_ sender: UIButton) {
        result()
        operating = true
        operation = .division
        sender.shine()
    }
    
    
    @IBAction func numberDecimalAction(_ sender: UIButton) {
        let currenTemp = auxFormatter.string(from: NSNumber(value: temp))
        guard let curren = currenTemp else {return}
        if !operating && curren.count >= Int(kMaxValue) {
            return
        }
        guard let text = resultLabel.text else {return}
        resultLabel.text = text + kDecimalSeparator
        decimal = true
        sender.shine()
    }
    
    
    
    
    @IBAction func numberAction(_ sender: UIButton) {
        operatorAC.setTitle("C", for: .normal)
        var currenTemp = auxFormatter.string(from: NSNumber(value: temp))
        guard let curren = currenTemp else {return}
        if !operating && curren.count >= Int(kMaxValue) {
            return
        }
        
        // Hemos seleccionado una operación
        if operating{
            total = total == 0 ? temp : total
            resultLabel.text = ""
            currenTemp = ""
            operating = false
        }
        // Hemos seleccionado decimales
        if decimal {
            currenTemp = "\(temp)\(kDecimalSeparator)"
            decimal = false
        }
        let number = sender.tag
        guard let current = currenTemp else {return}
        temp = Double(current + String(number))!
        resultLabel.text = printFormatter.string(from: NSNumber(value: temp))
        
        sender.shine()
    }
    
    // Limpia los valores
    private func clear () {
        operation = .none
        operatorAC.setTitle("AC", for: .normal)
        if temp != 0{
            resultLabel.text = "0"
        } else {
            total = 0
            result()
        }
    }
    
    // Obtiene el resultado final
    private func result() {
        
        switch operation {

        case .none:
            // No hacemos nada
            break
        case .addition:
            total = total + temp
            break
        case .sustraction:
            total = total - temp
            break
        case .multiplication:
            total = total * temp
            break
        case .division:
            total = total / temp
            break
        case .percent:
            temp = temp / 100
            total = temp
            break
        }
        
        // Formateo y muestro en pantalla
        if total <= kMaxValue || total >= kMinValue {
            resultLabel.text = printFormatter.string(from: NSNumber(value: total))
        }
        
        print("TOTAL\(total)")
        
    }
    
    
    
}
