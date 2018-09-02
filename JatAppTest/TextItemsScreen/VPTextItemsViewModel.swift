//
//  VPTextItemsViewModel.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class VPTextItemsViewModel{
    
    struct VPTextItemRepresentable{
        init(character:Character, count:Int) {
            self.count = .init(count)
            self.character = character == " " ? "Space" : .init(character)
        }
        let character: String
        let count: String
    }
    let disposeBag = DisposeBag()
    let items = Variable<[VPTextItemRepresentable]>([])
    let loading = Variable<Bool>(false)
    
    func getTextItems(){
        loading.value = true
        Networking.shared.getText()
            .map{$0.charDict}
            .map{$0.map{return VPTextItemRepresentable(character: $0, count: $1)}}
            .subscribe(onNext:{[weak self] items in
                self?.items.value = items
                self?.loading.value = false
            })
            .disposed(by: disposeBag)
        
//        return Observable.create{observer in
//            Networking.shared.getText {[weak self] text, error in
//                if let error = error{
//                    observer.onError(error)
//                    return
//                }
//                let items = text?.charDict.map{character, count in
//                    return VPTextItemRepresentable(character: character, count: count)
//                    } ?? []
//                observer.onNext(items)
//                observer.onCompleted()
//            }
//            return Disposables.create()
//        }
    }
}
