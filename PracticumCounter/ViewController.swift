//
//  ViewController.swift
//  PracticumCounter
//
//  Created by ANTON ZVERKOV on 08.02.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var PlusButton: UIButton!
    @IBOutlet weak var MinusButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    @IBOutlet weak var DigitView: UILabel!
    @IBOutlet weak var MaxCountWarning: UILabel!
    @IBOutlet weak var ChangesTextView: UITextView!
    @IBOutlet weak var InactiveButtonTapDetector: UIButton!
    
    private let maxValue: Int = 99
    private let maxHistoryStrings: Int = 15
    
    private enum CounerOperation {
        case plus
        case minus
        case reset
    }
    
    private var counterValue: Int = 0
    private var historyText: [String] = [] {
        didSet {
            if historyText.count > maxHistoryStrings && historyText.count > 1 {
                historyText.remove(at: 1)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PlusButton.isEnabled = true
        historyText = ["Last \(maxHistoryStrings) changes history:"]
        updateUI()
    }

    private func updateUI() {
        DigitView.text = String(counterValue)
        PlusButton.isEnabled = counterValue < maxValue
        MinusButton.isEnabled = counterValue > 0
        ResetButton.isEnabled = counterValue != 0
        MaxCountWarning.isHidden = counterValue < maxValue
        ChangesTextView.text = historyText.joined(separator: "\n")
    }
    
    private func changeCounterValue(_ operation: CounerOperation) {
        switch operation {
        case .plus:
            counterValue = counterValue < maxValue ? counterValue + 1 : counterValue
        case .minus:
            counterValue = counterValue > 0 ? counterValue - 1 : counterValue
        case .reset:
            counterValue = 0
        }
    }
    
    private func updateHistoryTextView(_ operation: CounerOperation) {
        switch operation {
        case .reset:
            historyText.append("[\(Date().toString())] VALUE RESET")
        default:
            historyText.append("[\(Date().toString())] Value changed by \(operation == .plus ? "+1" : "-1")")
        }
    }

    @IBAction func resetIsPressed(_ sender: Any) {
        changeCounterValue(.reset)
        updateHistoryTextView(.reset)
        updateUI()
    }
    
    @IBAction func plusButtonIsPressed(_ sender: Any) {
        changeCounterValue(.plus)
        updateHistoryTextView(.plus)
        updateUI()
    }
    
    @IBAction func minusButtonIsPressed(_ sender: Any) {
        changeCounterValue(.minus)
        updateHistoryTextView(.minus)
        updateUI()
    }
    
    @IBAction func inactiveButtonTapped(_ sender: Any) {
        historyText.append("...attemting to tap inactive minus button...")
        updateUI()
    }
    
}

