//
//  ViewModel.swift
//  GoodNewsMVVM
//
//  Created by The App Experts on 19/02/2021.
//  Copyright © 2021 The App Experts. All rights reserved.
//

import Foundation

protocol ViewModelProtocol: class {
    func refreshUI ()
    func setLabel ()
    func setBookmarkButton ()
}

class ViewModel {
    private var service: NetworkingProtocol
    private var defaults: UserDefaultsStoreProtocol
    private var coreDataManager: CoreDataManager
    weak var delegate:ViewModelProtocol?
    
    var model: Model? {
        didSet {
            delegate?.refreshUI()
        }
    }
    var user: User? {
        didSet {
            delegate?.setLabel()
            delegate?.setBookmarkButton()
        }
    }
    
    init(services: NetworkingProtocol = NetworkService(), userDefaults: UserDefaultsStoreProtocol = UserDefaultsStore()) {
        self.service = services
        self.defaults = userDefaults
        
        self.coreDataManager = CoreDataManager.shared
    }
    
    func requestModel() {
        let params:[String:String] = [ Const.urlMethod:Const.urlParamMethod,
                                       Const.urlFormat:Const.urlParamFormat,
                                       Const.urlLang:Const.urlParamLang
        ]
        guard let url = self.service.getURL(host: Const.urlHost, path: Const.urlPath, params: params) else {return}
        
        self.service.fetch(url: url) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.model = model
                    if self?.model?.author == nil {
                        self?.model?.author = Const.unknown
                    }
                }
                
            case .failure(let e):
                print("ERROR \(e)")
            }
        }
    }
}

extension ViewModel {
    func saveUser(user: User) {
        self.defaults.saveUser(user: user)
        self.user = user
    }
    
    func checkIfEntryExist() -> Bool {
        guard let noName = self.user?.name.isEmpty else {return false}
        if self.user == nil  || self.user?.name == nil || noName{
            return false
        }
        return true
    }
    
    func fetchUser() {
        self.user = self.defaults.fetchUser()        
    }
    
    func clearUserData() {
        self.defaults.deleteData()
        self.fetchUser()
    }
}

extension ViewModel {
    func saveQuote (author: String, quote: String) -> Bool{
        let ctx = self.coreDataManager.mainContext
        let q = Qoute(context: ctx)
        q.author = author
        q.text = quote
        print("Q -> \(q)")
        return self.coreDataManager.save()
    }
}
