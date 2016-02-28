//
//  ViewController.swift
//  RxActionExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//
//
//  In this project we have basic regsitration form that enables
//  button upon filling in all the fields. If every field has at
//  least one character, we acknowledge it as being "good". Of 
//  course in real world you would like to do some more filtering
//  like checking email or password & login length etc. But to modify
//  it for your needs there is not much to do other than overrite
//  mapping part where we just check the characters' count property.
//  This example shows how easy it can be to attach Action to a button
//  and remove all the boilerplate code like delegates and such.
//
//

import Action
import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet var formFields: [UITextField]!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var currentTranslation: CGFloat = 0
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupRX()
        setupUI()
    }
    
    func setupRX() {
        let validUsername = formFields // take array of inputs
            .map { input in
                input.rx_text.map { $0.characters.count > 0 } // map them into array of Observable<Bool>
            } // this allows us to use combineLatest, which fires up whenever any of the observables emits a signal
            .combineLatest { filters -> Bool in
                return filters.filter { $0 }.count == filters.count // if every input has length > 0, emit true
        }
        
        let action = Action<Void, Void>(enabledIf: validUsername) { input in
            let alert = UIAlertController(title: "Wooo!", message: "Registration completed!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return .empty()
        }
        registerButton.rx_action = action
    }
    
    func setupUI() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else { return }
        let margin: CGFloat = 10.0
        var responderY: CGFloat!
        formFields.forEach { field in
            if field.isFirstResponder() {
                responderY = CGRectGetMaxY(field.frame) + CGRectGetMinY(stackView.frame)
                return
            }
        }
        currentTranslation = currentTranslation + responderY - CGRectGetMinY(keyboardFrame) + margin
        if currentTranslation != 0 {
            UIView.animateWithDuration(0.3) {
                self.stackView.transform = CGAffineTransformMakeTranslation(0.0, (-1)*self.currentTranslation)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.3) {
            self.currentTranslation = 0.0
            self.stackView.transform = CGAffineTransformMakeTranslation(0.0, 0.0)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        view.endEditing(true)
    }
    
}

