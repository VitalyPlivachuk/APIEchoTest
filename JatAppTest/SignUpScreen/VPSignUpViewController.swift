//
//  VPSignUpViewController.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 8/31/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VPSignUpViewController: UIViewController {
    
    @IBOutlet weak var controlsView: UIView!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let viewModel = VPSignUpViewModel()
    let router = VPSignUpRouter()
    let disposeBag = DisposeBag()
    
    enum Route: String {
        case login
        case signUp
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createViewModelBinding();
        createCallbacks()
        createUiReactions()
    }
    
    func createUiReactions(){
        UIApplication.keyboardHeight
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{[unowned self] height in
                self.scrollView.contentInset.bottom = height - self.controlsView.frame.maxY
                self.scrollView.contentOffset.y = height == 0 ? 0 : self.controlsView.frame.minY - 30
            })
            .disposed(by: disposeBag)
    }
    
    func createViewModelBinding(){
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap.do(onNext:  { [unowned self] in
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
            self.nameTextField.resignFirstResponder()
        }).subscribe(onNext: { [unowned self] in
            self.router.route(to: Route.login.rawValue, from: self, parameters: nil)
        }).disposed(by: disposeBag)
        
        signUpButton.rx.tap.do(onNext:  { [unowned self] in
            self.emailTextField.resignFirstResponder()
            self.passwordTextField.resignFirstResponder()
            self.nameTextField.resignFirstResponder()
        }).subscribe(onNext: { [unowned self] in
            self.viewModel.signUpUser()
        }).disposed(by: disposeBag)
        
    }
    
    func createCallbacks (){
        
        // success
        viewModel.isSuccess.asObservable()
            .bind{[unowned self] value in
                guard value else {return}
                self.router.route(to: Route.signUp.rawValue, from: self, parameters: nil)
                NSLog("Successfull")
            }.disposed(by: disposeBag)
        
        // errors
        viewModel.errorMsg.asObservable()
            .bind {[unowned self] error in
                if let error = error{
                    self.showErrorAlert(error:error)
                }
            }.disposed(by: disposeBag)
    }
}
