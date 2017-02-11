//
//  AddYearViewController.swift
//  summator
//
//  Created by Alexey Pichukov on 11.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddYearViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    private weak var delegate: Completeble?
    private let disposeBag = DisposeBag()
    
    init(delegate: Completeble?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createButton.layer.cornerRadius = createButton.frame.width / 2
        createButton.backgroundColor = .white
        nameTextField.rx.text
            .map({ (value) in
                guard value != nil else {
                    return false
                }
                return !value!.isEmpty
            })
            .bindTo(createButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func createButtonAction(_ sender: Any) {
        guard nameTextField.text != nil else {
            return
        }
        view.endEditing(true)
        delegate?.complete(object: Year(name: nameTextField.text!, sum: 0))
    }
}
