//
//  CreditCardViewController.swift
//  CreditCardValidator
//
//  Created by Maciej Marut on 05.11.2017.
//  Copyright © 2017 Maciej Marut. All rights reserved.
//

import UIKit

class CreditCardViewController: UIViewController {
    
    //MARK: - Constants
    let apiHTML = "https://api.bincodes.com/cc/?"
    let apiFormat = "format=json"
    let apiKey = "api_key="                                 //API KEY REQUIRED - Get yours for free @ www.bincodes.com
    let apiCC = "cc="
    
    //MARK: - Labels
    let cardNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Card number"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardExpirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Expiration Date"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardCVCLabel: UILabel = {
        let label = UILabel()
        label.text = "CVC/CVV"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardNumberErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Invalid number"
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardExpirationDateErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Invalid date"
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardCVCErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "Invalid code"
        label.textColor = .red
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - TextViews
    let cardNumberTextView: UITextView = {
        let textView = UITextView()
        textView.text = "1234 1234 1234 1234"
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardType = .numberPad
        return textView
    }()
    
    let cardExpirationDateTextView: UITextView = {
        let textView = UITextView()
        textView.text = "01/01"
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardType = .numberPad
        return textView
    }()
    
    let cardCVCTextView: UITextView = {
        let textView = UITextView()
        textView.text = "CVC/CVV"
        textView.textColor = UIColor.lightGray
        textView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.keyboardType = .numberPad
        return textView
    }()
    
    //MARK: - Buttons
    let validateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Validate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(validateCreditCard), for: .touchUpInside)
        return button
    }()
    
    let generateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateCreditCard), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Functions
    func loadUserInterface() {
        view.addSubview(cardNumberLabel)
        view.addSubview(cardNumberTextView)
        view.addSubview(cardNumberErrorLabel)
        view.addSubview(cardExpirationDateLabel)
        view.addSubview(cardExpirationDateTextView)
        view.addSubview(cardExpirationDateErrorLabel)
        view.addSubview(cardCVCLabel)
        view.addSubview(cardCVCTextView)
        view.addSubview(cardCVCErrorLabel)
        view.addSubview(validateButton)
        view.addSubview(generateButton)
    }
    
    func setupLayout() {
        cardNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        cardNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardNumberTextView.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 8).isActive = true
        cardNumberTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardNumberErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cardNumberErrorLabel.centerYAnchor.constraint(equalTo: cardNumberTextView.centerYAnchor).isActive = true
        cardExpirationDateLabel.topAnchor.constraint(equalTo: cardNumberTextView.bottomAnchor, constant: 16).isActive = true
        cardExpirationDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardExpirationDateTextView.topAnchor.constraint(equalTo: cardExpirationDateLabel.bottomAnchor, constant: 8).isActive = true
        cardExpirationDateTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardExpirationDateErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cardExpirationDateErrorLabel.centerYAnchor.constraint(equalTo: cardExpirationDateTextView.centerYAnchor).isActive = true
        cardCVCLabel.topAnchor.constraint(equalTo: cardExpirationDateTextView.bottomAnchor, constant: 16).isActive = true
        cardCVCLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardCVCTextView.topAnchor.constraint(equalTo: cardCVCLabel.bottomAnchor, constant: 8).isActive = true
        cardCVCTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cardCVCErrorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cardCVCErrorLabel.centerYAnchor.constraint(equalTo: cardCVCTextView.centerYAnchor).isActive = true
        validateButton.topAnchor.constraint(equalTo: cardCVCTextView.bottomAnchor, constant: 16).isActive = true
        validateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        generateButton.topAnchor.constraint(equalTo: cardCVCTextView.bottomAnchor, constant: 16).isActive = true
        generateButton.leadingAnchor.constraint(equalTo: validateButton.trailingAnchor, constant: 16).isActive = true
    }
    
    func hideErrorLabels() {
        cardNumberErrorLabel.textColor = .red
        cardNumberErrorLabel.isHidden = true
        cardExpirationDateErrorLabel.isHidden = true
        cardCVCErrorLabel.isHidden = true
    }
    
    //MARK: - Private functions
    private func generateRandomFourDigits() -> Int {
        var random = Int(arc4random_uniform(9999))
        if random <= 999 {
            random += 1000
        }
        return random
    }
    
    private func validateWithAdress(apiURL: URL) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x: generateButton.frame.maxX, y: generateButton.frame.maxY - 41, width: 50, height: 50)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        
        let session = URLSession.shared
        session.dataTask(with: apiURL) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                    DispatchQueue.main.sync {
                        self.cardNumberErrorLabel.isHidden = false
                        if let valid = json["valid"] as? String {
                            if valid == "true" {
                                self.cardNumberErrorLabel.text = "Valid number"
                                self.cardNumberErrorLabel.textColor = .green
                            } else {
                                self.cardNumberErrorLabel.text = "Invalid number"
                            }
                        } else if let message = json["message"] as? String, let err = json["error"] as? String {
                            print("\(err): \(message)")
                            self.cardNumberErrorLabel.text = "Invalid number"
                        }
                        activityIndicator.stopAnimating()
                    }
                } catch let jsonErr {
                    print("Failed to serialize: ", jsonErr)
                }
            } else {
                print("There was an error while connecting to remote services.")
            }
        }.resume()
    }
    
    @objc private func validateCreditCard(sender: UIButton) {
        self.view.endEditing(true)
        hideErrorLabels()
        if apiKey != "api_key=" {
            if self.cardNumberTextView.textColor == .lightGray {
                self.cardNumberErrorLabel.isHidden = false
                self.cardNumberErrorLabel.text = "Invalid number"
            }
            if self.cardExpirationDateTextView.textColor == .lightGray {
                self.cardExpirationDateErrorLabel.isHidden = false
            }
            if self.cardCVCTextView.textColor == .lightGray {
                self.cardCVCErrorLabel.isHidden = false
            }
            if self.cardNumberTextView.textColor == .black && self.cardExpirationDateTextView.textColor == .black && self.cardCVCTextView.textColor == .black {
            let cardNumber = self.cardNumberTextView.text!
            let apiURL = apiHTML + apiFormat + "&" + apiKey + "&" + apiCC + cardNumber.replacingOccurrences(of: " ", with: "")
            validateWithAdress(apiURL: URL(string: apiURL)!)
            }
        } else {
            cardNumberErrorLabel.text = "API KEY REQUIRED"
            cardNumberErrorLabel.isHidden = false
        }
    }
    
    @objc private func generateCreditCard(sender: UIButton) {
        self.view.endEditing(true)
        hideErrorLabels()
        var creditCardNumber = ""
        var result = 0

        repeat {
            result = 0
            creditCardNumber = "\(generateRandomFourDigits()) \(generateRandomFourDigits()) \(generateRandomFourDigits()) \(generateRandomFourDigits())"
            let randomCreditCardNumber = creditCardNumber.replacingOccurrences(of: " ", with: "")
            let randomCreditCardNumberArray = [Character](randomCreditCardNumber)
            var intArray: [Int] = []
            for char in randomCreditCardNumberArray {
                intArray.append(Int(String(char))!)
            }
            let checkDigit = intArray.popLast()!
            for index in intArray.indices {
                if (index % 2) == 0 {
                    intArray[index] *= 2
                    if intArray[index] >= 10 {
                        intArray[index] -= 9
                    }
                }
            }
            for number in intArray {
                result += number
            }
            result += checkDigit
        } while result % 10 != 0
        self.cardNumberTextView.text = creditCardNumber
        self.cardNumberTextView.textColor = .black
        
        let date = Date()
        let yearFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        yearFormatter.dateFormat = "yy"
        monthFormatter.dateFormat = "MM"
        let year = Int(yearFormatter.string(from: date))!
        let month = Int(monthFormatter.string(from: date))!
        var randomYear: Int = {
            let random = Int(arc4random_uniform(3))
            return year + random
        }()
        let randomMonth: Int = {
            let random = Int(arc4random_uniform(11)) + 1
            if randomYear == year && random < month {
                randomYear += 1
                return random
            } else if randomYear == year + 3 && random > month {
                randomYear -= 1
                return random
            } else {
                return random
            }
        }()
        self.cardExpirationDateTextView.text = "\(randomMonth)/\(randomYear)"
        self.cardExpirationDateTextView.textColor = .black
        
        let randomCVC = arc4random_uniform(999)
        if randomCVC < 10 {
            self.cardCVCTextView.text = "00\(randomCVC)"
        } else if randomCVC < 100 {
            self.cardCVCTextView.text = "0\(randomCVC)"
        } else {
            self.cardCVCTextView.text = "\(randomCVC)"
        }
        self.cardCVCTextView.textColor = .black
    }
}
