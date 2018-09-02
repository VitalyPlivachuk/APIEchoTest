//
//  UIViewController+ErrorAlert.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit

extension UIViewController{
    func showErrorAlert(error:Error){
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true)
    }
}
