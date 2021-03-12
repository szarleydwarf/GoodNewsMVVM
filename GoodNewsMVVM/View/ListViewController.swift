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
        self.vm.fetchList()
        
        self.vm.delegate = self
        
        self.quotesTable.delegate = self
        self.quotesTable.dataSource = self
        
        self.refreshLabel()
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
    func refreshLabel() {
        guard let user = self.vm.user else {return}
        let newLabelText:String = Const.tableLabel.replacingOccurrences(of: Const.userName, with: user.name)
        let text = newLabelText.replacingOccurrences(of: Const.bookmarked, with: user.bookmarkCounts)
        print("List UI refreshed \(text)")
        self.userInfoLabel.text = newLabelText
    }
}
