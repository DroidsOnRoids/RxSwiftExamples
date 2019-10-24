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
        let validUsernameCollection = formFields // take array of inputs
            .map { input in
                input.rx.text
                    .filter { $0 != nil }
                    .map { $0! }
                    .map { $0.count > 0 } // map them into array of Observable<Bool>
            } // this allows us to use combineLatest, which fires up whenever any of the observables emits a signal
        
        let validUsername = Observable.combineLatest(validUsernameCollection) { filters in
            return filters.filter { $0 }.count == filters.count // if every input has length > 0, emit true
        }
        
        let action = Action<Void, Void>(enabledIf: validUsername) { input in
            let alert = UIAlertController(title: "Wooo!", message: "Registration completed!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return .empty()
        }
        
        registerButton.rx.action = action
    }
    
    func setupUI() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let margin: CGFloat = 10.0
        var responderY: CGFloat!
        formFields.forEach { field in
            if field.isFirstResponder {
                responderY = field.frame.maxY + stackView.frame.minY
                return
            }
        }
        currentTranslation = currentTranslation + responderY - keyboardFrame.minY + margin
        if currentTranslation != 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.transform = CGAffineTransform(translationX: 0.0, y: (-1)*self.currentTranslation)
            }) 
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.currentTranslation = 0.0
            self.stackView.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
        }) 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
