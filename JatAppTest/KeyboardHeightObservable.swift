//
//  KeyboardHeightObservable.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import RxSwift
import RxCocoa

extension UIApplication{
    static var keyboardHeight: Observable<CGFloat> {
        return Observable
            .from([
                NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow)
                    .map { notification -> CGFloat in
                        (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
                },
                NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillHide)
                    .map { _ -> CGFloat in
                        0
                }
                ])
            .merge()
    }

}
