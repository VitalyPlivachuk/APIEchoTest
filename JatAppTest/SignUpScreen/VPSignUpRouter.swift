//
//  VPSignUpRouter.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit


class VPSignUpRouter: Router {
    
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
    {
        guard let route = VPSignUpViewController.Route(rawValue: routeID) else {
            return
        }
        switch route {
        case .login:
            context.navigationController?.popViewController(animated: true)
        case .signUp:
            context.navigationController?.dismiss(animated: true)
        }
    }
}
