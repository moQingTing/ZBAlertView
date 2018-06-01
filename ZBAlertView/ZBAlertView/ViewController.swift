//
//  ViewController.swift
//  ZBAlertView
//
//  Created by mqt on 2018/6/1.
//  Copyright © 2018年 mqt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func click(_ sender: Any) {
        let view = sender as! UIButton
        let alert = ZBAlertView(view: view, showString: "能帮助孩子提高思维敏感力和灵活性，同时在心理上更会提高孩子对学习")
        alert.show(duration: 3)
    }
    
}

extension ViewController:UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let alert = ZBAlertView(view: textField, showString: "时刻对这个世界保持着敬畏之心，心灵的宁静是需要修身养性")
        alert.show(duration: 2)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



