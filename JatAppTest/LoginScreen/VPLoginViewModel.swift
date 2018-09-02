//
//  VPLoginViewModel.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import Foundation
import ApiECHO
import RxSwift

class VPLoginViewModel{
    
    var email: Variable<String> = Variable("")
    var password: Variable<String> = Variable("")
    var disposeBag = DisposeBag()
    
    let isSuccess : Variable<Bool> = Variable(false)
    let isLoading : Variable<Bool> = Variable(false)
    let errorMsg : Variable<Error?> = Variable(nil)
    
    func loginUser(){
        self.isLoading.value = true
        Networking.shared.login(email: email.value, password: password.value)
            .subscribe(onNext:{[weak self] _ in
                self?.isLoading.value = false
                self?.isSuccess.value = true
            }, onError:{[weak self] error in
                self?.isLoading.value = false
                self?.errorMsg.value = error
            })
        .disposed(by: disposeBag)
    }
}
