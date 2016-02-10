//
//  ViewController.swift
//  RxActionExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
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
    }

}

