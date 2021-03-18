//
//  ListViewController.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 10/03/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    var vm:ListViewModel!
    private var alerts: AlertsProtocol!
    
    @IBOutlet weak var quotesTable: UITableView!
    @IBOutlet weak var userInfoLabel: UILabel!{
        didSet {
            userInfoLabel.text = Const.tableLabel
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alerts = Alerts()
        self.vm.delegate = self
        
        self.quotesTable.delegate = self
        self.quotesTable.dataSource = self
        
        self.refreshLabel()
        
        Toast().displayToast(in: self.view)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.quotesList?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        guard let q = self.vm.quotesList else {return UITableViewCell()}
        self.update(cell, with: q[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func update(_ cell:UITableViewCell?, with qoute: Qoute) {
        cell?.detailTextLabel?.text = qoute.author
        cell?.textLabel?.text = qoute.text
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = self.vm.quotesList {
            let element = list[indexPath.row]
                self.alerts.displayAlert(in: self, of: .info, with: element) { _ in
            }
        }
    }
}

extension ListViewController: ListViewModelProtocol {
    func refreshLabel() {
        guard let user = self.vm.user else {return}
        var newLabelText:String = Const.tableLabel.replacingOccurrences(of: Const.userName, with: user.name)
        newLabelText = newLabelText.replacingOccurrences(of: Const.bookmarked, with: "\(user.bookmarkCounts)")
        self.userInfoLabel.text = newLabelText
    }
}
