//
//  VPTextItemsViewControlller.swift
//  JatAppTest
//
//  Created by Vitaly Plivachuk on 9/1/18.
//  Copyright © 2018 Vitaly Plivachuk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VPTextItemsViewControlller:UIViewController{
    
    var viewModel = VPTextItemsViewModel()
    let tableView = UITableView(frame: .zero)
    let router = VPTextItemsRouter()
    private let cellIdentifier = "Cell"
    private let disposeBag = DisposeBag()
    
    enum Route:String{
        case login
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTableViewBinding()
        tableView.refreshControl = UIRefreshControl(frame: .init(origin: .zero, size: .init(width:20, height:20)))
        tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext:{[weak self] in
                self?.viewModel.getTextItems()
            })
            .disposed(by: disposeBag)
        viewModel.loading.asDriver()
            .drive(onNext:{[weak self] loading in
                loading
                    ? self?.tableView.refreshControl?.beginRefreshing()
                    : self?.tableView.refreshControl?.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Networking.shared.loggedIn.asObservable()
            .subscribe(onNext:{[unowned self] logged in
                if logged {
                    self.viewModel.getTextItems()
                } else {
                    self.router.route(to: Route.login.rawValue, from: self, parameters: nil)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)])
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupTableViewBinding() {
        
        viewModel.items.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: UITableViewCell.self)){row,element, cell in
                cell.textLabel?.text = "\(element.character) - \(element.count)"
            }.disposed(by: disposeBag)
    }
}
