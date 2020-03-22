//
//  ViewController.swift
//  SignUp
//
//  Created by delma on 2020/03/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordConfirmTF: UITextField!
    @IBOutlet var nameTF: UITextField!
    
    @IBOutlet var idAssistLabel: UILabel!
    @IBOutlet var passwordAssistLabel: UILabel!
    @IBOutlet var passwordConfirmAssistLabel: UILabel!
    @IBOutlet var nameAssistLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTF.delegate = self
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.layer.borderWidth = 1.0
        
        if textField == idTextField {
            judgeValidID(textField)
            let newLength = textField.text!.count + string.count - range.length
            return !(newLength > 20)
        }
        
        if textField == passwordTextField {
            if isValidPassword(password: textField.text!) {
                textField.layer.borderColor = UIColor.green.cgColor
            }else {
                textField.layer.borderColor = UIColor.red.cgColor
            }
        }
        
        if textField == passwordConfirmTF {
            if textField.text! == passwordTextField.text! {
                textField.layer.borderColor = UIColor.green.cgColor
            }else {
                textField.layer.borderColor = UIColor.red.cgColor
            }
        }
        return true
    }
    
    func judgeValidID(_ textField: UITextField) {
        //서버에서 아이디 가져와 중복되는지 확인해야 함
        let text = textField.text!
        if !isValidId(id: text) {
            textField.layer.borderColor = UIColor.red.cgColor
            idAssistLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
            idAssistLabel.textColor = UIColor.red
            
        }else {
            textField.layer.borderColor = UIColor.black.cgColor
            idAssistLabel.text = "사용 가능한 아이디입니다."
            idAssistLabel.textColor = UIColor.green
            
        }
    }
    
    @IBAction func pressNextBtn(_ sender: Any) {
        print(idTextField.text!)
    }
    
    func isValidId(id: String) -> Bool {
        let idRegEx = "^(?=.*[a-z])(?=.*[0-9])[a-z0-9-_]{5,20}"
        let idTest = NSPredicate(format: "SELF MATCHES %@", idRegEx)
        return idTest.evaluate(with: id)
    }
    
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$!%*?&])[A-Za-z0-9$@$!%*?&]{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        
        return passwordTest.evaluate(with: password)
    }
    
}

