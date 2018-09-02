//
//  VPTextItemsRouter.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit

class VPTextItemsRouter:Router{
    func route(to routeID: String, from context: UIViewController, parameters: Any?) {
        guard let route = VPTextItemsViewControlller.Route(rawValue: routeID) else {
            return
        }
        switch route {
        case .login:
            let vc = VPLoginViewController.init(nibName: "VPLoginViewController", bundle: nil)
            let navC = UINavigationController(rootViewController: vc)
            navC.isNavigationBarHidden = true
            context.present(navC, animated: true)
        }
    }
}
