//
//  AccessToken.swift
//  CSAPITask
//
//  Created by Aleksandr on 04/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit

class AccessToken: NSObject, NSCoding {
    
    public private(set) var token: String = ""
    public private(set) var expiresDate: Date = Date()
    public private(set) var userID: String = ""
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: "token")
        aCoder.encode(expiresDate, forKey: "expiresDate")
        aCoder.encode(userID, forKey: "userID")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedToken = aDecoder.decodeObject(forKey: "token") as? String,
            let decodedExpiresDate = aDecoder.decodeObject(forKey: "expiresDate") as? Date,
            let decodedUserID = aDecoder.decodeObject(forKey: "userID") as? String {
            
            self.token = decodedToken
            self.expiresDate = decodedExpiresDate
            self.userID = decodedUserID
        }
    }
    
    static var storage = KeyChainStorage.keychainStorage(tag: "CSAPITask.keys.access_token")
    
    private override init() {}
    
    static func currentToken() -> AccessToken? {
        
        guard let storage = AccessToken.storage else {
            return nil
        }
        
        do {
            let data = try storage.find()
            guard let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? AccessToken else {
                return nil
            }
            
            return result
        } catch KeyChainStorage.KeyChainStorageError.cannotFindItem {
            print("AccessToken.currentToken() cannot find item")
        } catch let err {
            print(err.localizedDescription)
        }
        
        return nil
    }
    
    static func add(token: String, expiresDate: Date, userID: String) {
        
        guard let storage = AccessToken.storage else {
            return
        }
        
        let accessToken = AccessToken()
        accessToken.token = token
        accessToken.expiresDate = expiresDate
        accessToken.userID = userID
        
        do {
            try storage.delete()
        } catch {
            print("AccessToken.add() cannot delete token from storage")
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: accessToken, requiringSecureCoding: false)
            try storage.add(item: data)
        } catch {
            print("AccessToken.add() cannot add token to storage")
        }
    }
}

extension AccessToken {
    override var description: String {
        return "token: \(token)\n userID: \(userID)\n expiresIn: \(expiresDate)"
    }
}
