//
//  VPLoginRouter.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit


class VPLoginRouter: Router {
    
    func route(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?)
    {
        guard let route = VPLoginViewController.Route(rawValue: routeID) else {
            return
        }
        switch route {
        case .login:
            context.navigationController?.dismiss(animated: true)
        case .signUp:
            let vc = VPSignUpViewController.init(nibName: "VPSignUpViewController", bundle: nil)
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
