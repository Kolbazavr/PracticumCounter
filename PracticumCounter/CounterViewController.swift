//
//  ViewController.swift
//  PracticumCounter
//
//  Created by ANTON ZVERKOV on 08.02.2025.
//

import UIKit

final class CounterViewController: UIViewController {
    
    @IBOutlet weak private var plusButton: UIButton!
    @IBOutlet weak private var minusButton: UIButton!
    @IBOutlet weak private var resetButton: UIButton!
    @IBOutlet weak private var digitView: UILabel!
    @IBOutlet weak private var maxCountWarning: UILabel!
    @IBOutlet weak private var changesTextView: UITextView!
    @IBOutlet weak private var inactiveButtonTapDetector: UIButton!
    
    private let maxValue: Int = 99
    private let maxHistoryStrings: Int = 15
    
    private enum CounterOperation {
        case plus
        case minus
        case reset
    }
    
    private var counterValue: Int = 0
    private var historyText: [String] = [] {
        didSet {
            if historyText.count > maxHistoryStrings {
                historyText.remove(at: 1)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        plusButton.isEnabled = true
        historyText = ["Last \(maxHistoryStrings) changes history:"]
        updateUI()
    }

    private func updateUI() {
        digitView.text = String(counterValue)
        plusButton.isEnabled = counterValue < maxValue
        minusButton.isEnabled = counterValue > 0
        resetButton.isEnabled = counterValue != 0
        maxCountWarning.isHidden = counterValue < maxValue
        changesTextView.text = historyText.joined(separator: "\n")
    }
    
    private func changeCounterValue(_ operation: CounterOperation) {
        switch operation {
        case .plus:
            counterValue = counterValue < maxValue ? counterValue + 1 : counterValue
        case .minus:
            counterValue = counterValue > 0 ? counterValue - 1 : counterValue
        case .reset:
            counterValue = 0
        }
    }
    
    private func updateHistoryTextView(_ operation: CounterOperation) {
        switch operation {
        case .reset:
            historyText.append("[\(Date().toString())] VALUE RESET")
        default:
            historyText.append("[\(Date().toString())] Value changed by \(operation == .plus ? "+1" : "-1")")
        }
    }

    @IBAction private func resetIsPressed(_ sender: Any) {
        changeCounterValue(.reset)
        updateHistoryTextView(.reset)
        updateUI()
    }
    
    @IBAction private func plusButtonIsPressed(_ sender: Any) {
        changeCounterValue(.plus)
        updateHistoryTextView(.plus)
        updateUI()
    }
    
    @IBAction private func minusButtonIsPressed(_ sender: Any) {
        changeCounterValue(.minus)
        updateHistoryTextView(.minus)
        updateUI()
    }
    
    @IBAction private func inactiveButtonTapped(_ sender: Any) {
        historyText.append("..attempting to tap inactive minus button..")
        updateUI()
    }
    
}

