//
//  MainViewController
//  CreditCardValidator
//
//  Created by Maciej Marut on 04.11.2017.
//  Copyright © 2017 Maciej Marut. All rights reserved.
//

import UIKit

class MainViewController: CreditCardViewController {
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserInterface()
        setupLayout()
        
        cardNumberTextView.delegate = self
        cardExpirationDateTextView.delegate = self
        cardCVCTextView.delegate = self
    }
    
    //MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == cardNumberTextView {
            if textView.text.count == 19 {
                if text == "" {
                    return true
                } else {
                    return false
                }
            }
            if textView.text.count == 4 || textView.text.count == 9 || textView.text.count == 14 {
                if !(text == "") {
                    textView.text = textView.text + " "
                }
            }
            return textView.text.count < 19
        } else if textView == cardExpirationDateTextView {
            if textView.text.count == 5 {
                if text == "" {
                    return true
                } else {
                    return false
                }
            }
            if textView.text.count == 2 {
                if !(text == "") {
                    textView.text = textView.text + "/"
                }
            }
            return textView.text.count < 5
        } else if textView == cardCVCTextView {
            if textView.text.count == 3 {
                if text == "" {
                    return true
                } else {
                    return false
                }
            }
            return textView.text.count < 3
        }
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == cardNumberTextView {
            if textView.text.count == 19 {
                cardExpirationDateTextView.becomeFirstResponder()
            }
        } else if textView == cardExpirationDateTextView {
            if textView.text.count == 5 {
                cardCVCTextView.becomeFirstResponder()
            }
        }
    }
}

//MARK: - UITextViewDelegate Functions
extension MainViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        hideErrorLabels()
        if cardNumberTextView.isFirstResponder {
            if cardNumberTextView.textColor == UIColor.lightGray {
                cardNumberTextView.textColor = UIColor.black
                cardNumberTextView.text = nil
            }
        } else if cardExpirationDateTextView.isFirstResponder {
            if cardExpirationDateTextView.textColor == UIColor.lightGray {
                cardExpirationDateTextView.textColor = UIColor.black
                cardExpirationDateTextView.text = nil
            }
        } else if cardCVCTextView.isFirstResponder {
            if cardCVCTextView.textColor == UIColor.lightGray {
                cardCVCTextView.textColor = UIColor.black
                cardCVCTextView.text = nil
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if cardNumberTextView.text.isEmpty {
            cardNumberTextView.textColor = UIColor.lightGray
            cardNumberTextView.text = "1234 1234 1234 1234"
        }
        if cardExpirationDateTextView.text.isEmpty {
            cardExpirationDateTextView.textColor = UIColor.lightGray
            cardExpirationDateTextView.text = "01/01"
        }
        if cardCVCTextView.text.isEmpty {
            cardCVCTextView.textColor = UIColor.lightGray
            cardCVCTextView.text = "CVC/CVV"
        }
    }
}


