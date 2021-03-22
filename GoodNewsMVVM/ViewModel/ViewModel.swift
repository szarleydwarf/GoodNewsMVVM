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
    func refreshImageLabel()
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
    
    var image: Image? {
        didSet {
            delegate?.refreshImageLabel()
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
    
    func requestImage() {
        let params:[String:String] = [ Const.urlKeyPixabay:Const.urlParamKey,
                                       Const.urlQueryPixabay:Const.urlQueryParamPixabay,
                                       Const.urlImageType:Const.urlImageTypeParam
        ]
        guard let url = self.service.getURL(host: Const.urlHostImages, path: Const.urlPathImages, params: params) else {return}
        print("URL >> \(url)")
        self.service.fetchWithAlamo(url: url) { [weak self] result in
            switch result {
            case .success(let image):
                print("SUCCESS \(image)")
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure(let e):
                print("ERROR IMAGE ALAMO \(e)")
            }
        }
    }
}

extension ViewModel {
    func saveUser(user: User) {
        self.defaults.saveUser(user: user)
        self.user = user
        self.user?.qouteList = [Qoute]()
    }
    
    // todo check if quote exist in list before adding
    func checkIfEntryExist() -> Bool {
        return false
    }
    
    func checkIfUserExist() -> Bool {
        guard let noName = self.user?.name.isEmpty else {return false}
        if self.user == nil  || self.user?.name == nil || noName{
            return false
        }
        return true
    }
    
    func fetchUser() {
        self.user = self.defaults.fetchUser()
        self.user?.qouteList = self.coreDataManager.fetch()
    }
    
    func clearUserData() {
        if let list = self.user?.qouteList {
            self.coreDataManager.clearCoreData(list: list)
        }
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
        self.user?.qouteList?.append(q)
        return self.coreDataManager.save()
    }
}
