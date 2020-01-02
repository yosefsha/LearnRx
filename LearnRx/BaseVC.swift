//
//  BaseViewController.swift
//  MyMeSwift
//
//  Created by uri shaket on 04/11/2018.
//  Copyright © 2018 Orcam. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var bag = DisposeBag()
    var spinner: UIActivityIndicatorView?
    
    var isShownAsFullScreen: Bool = false

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(self) received memory warning")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.isShownAsFullScreen = self.parent is UINavigationController

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isShownAsFullScreen {
            self.logScreenTime()
        }
    }
    
    func setupSpinner() {
        self.spinner = UIActivityIndicatorView()
        self.view.addSubview(self.spinner!)
    }
    
    func getDescription() -> String {
        return String(describing: type(of: self))
    }
    
    // used for full screens (not nested view controllers)
    func logScreenTime() {

    }
}

protocol BaseViewControllerProtocol {
    func getDescription() -> String
}
