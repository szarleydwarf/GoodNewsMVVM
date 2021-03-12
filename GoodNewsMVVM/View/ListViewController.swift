//
//  ListViewController.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 10/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    var vm:ListViewModel!
   
    @IBOutlet weak var quotesTable: UITableView!
    @IBOutlet weak var userInfoLabel: UILabel!{
        didSet {
            userInfoLabel.text = Const.tableLabel
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.vm = ListViewModel()
        self.vm.fetchList()
        
        self.vm.delegate = self
        
        self.quotesTable.delegate = self
        self.quotesTable.dataSource = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

extension ListViewController: ListViewModelProtocol {
    func refreshUI() {
        print("List UI refreshed")
    }
}
