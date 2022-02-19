//
//  BaseViewModel.swift
//  Airalo
//
//  Created by Alihan Aktay on 8.10.2020.
//  Copyright © 2021 Airalo. All rights reserved.
//

import Foundation

protocol BaseViewModelDataSource: AnyObject {
    
}

protocol BaseViewModelEventSource: AnyObject {

}

protocol BaseViewModelProtocol: BaseViewModelDataSource, BaseViewModelEventSource {
    func viewDidLoad()
}

class BaseViewModel<R: Router>: BaseViewModelProtocol {
    
    let router: R

    init(router: R) {
        self.router = router
    }
    
    func viewDidLoad() {}
    
    deinit {
        debugPrint("deinit \(self)")
    }
    
}
