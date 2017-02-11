//
//  YearsViewController.swift
//  summator
//
//  Created by Alexey Pichukov on 10.02.17.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YearsViewController: UIViewController {
    
    @IBOutlet weak var sumView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var yearsViewModel: YearsViewModel
    fileprivate weak var delegate: ActionAddeble?
    
    fileprivate let transition = CustomTransition()
    fileprivate var animationCenterPoint: CGPoint?
    
    convenience init() {
        self.init(viewModel: YearsViewModel(), delegate: nil)
    }
    
    init(viewModel: YearsViewModel, delegate: ActionAddeble?) {
        self.yearsViewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareElements()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        tableViewDelegadeSetting()
        makeBindings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YearsViewController {
    fileprivate func prepareElements() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = false
        navigationBar?.shadowImage = UIImage()
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.barTintColor = UIColor(hexString: "65C6BB")
        navigationBar?.barStyle = .black
        sumView.backgroundColor = UIColor(hexString: "65C6BB")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonAction))
        navigationItem.rightBarButtonItem = addButton
        guard let buttonView = addButton.value(forKey: "view") as? UIView else {
            return
        }
        // Save start point for custom animation
        animationCenterPoint = buttonView.frame.center()
    }
    
    @objc private func addButtonAction() {
        delegate?.addAction()
    }
}

extension YearsViewController: UITableViewDelegate {
    
    fileprivate func tableViewDelegadeSetting() {
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func makeBindings() {
        let cellNib = UINib(nibName: "YearTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "YearCell")
        
        yearsViewModel.years
            .asObservable().bindTo(tableView.rx.items(cellIdentifier: "YearCell", cellType: YearTableViewCell.self)) { (row, year, cell) in
                cell.setYear(year)
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Year.self)
            .subscribe(onNext: { year in
                
            })
            .addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

// MARK: Prepare custom transitions
extension YearsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard animationCenterPoint != nil else {
            return nil
        }
        transition.duration = 0.3
        transition.transitionMode = .present
        transition.startingPoint = animationCenterPoint!
        transition.transitionColor = UIColor(hexString: "65C6BB")
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard animationCenterPoint != nil else {
            return nil
        }
        transition.transitionMode = .dismiss
        transition.transitionColor = UIColor(hexString: "65C6BB")
        transition.duration = 0.4
        guard let tableViewOriginPoint = tableView.superview?.convert(tableView.frame.origin, to: nil) else {
            return transition
        }
        let dismissPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: tableViewOriginPoint.y + 80)
        transition.dismissPoint = dismissPoint
        return transition
    }
}
