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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let validUsername = formFields
            .map { input in
                input.rx_text.map { $0.characters.count > 0 }
            }
            .combineLatest { (filters) -> Bool in
                return filters.filter { return $0 }.count == filters.count
            }
        let action = Action<Void, Void>(enabledIf: validUsername) { input in
            let alert = UIAlertController(title: "Wooo!", message: "Registration completed!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return .empty()
        }
        registerButton.rx_action = action
    }

}

