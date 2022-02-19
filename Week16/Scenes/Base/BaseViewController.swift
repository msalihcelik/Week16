//
//  BaseViewController.swift
//  Airalo
//
//  Created by Alihan Aktay on 8.10.2020.
//  Copyright © 2021 Airalo. All rights reserved.
//

import UIKit

class BaseViewController<V: BaseViewModelProtocol>: UIViewController {
    var viewModel: V
    
    init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // swiftlint:enable fatal_error unavailable_function
    
    deinit {
        debugPrint("deinit: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
        
}
