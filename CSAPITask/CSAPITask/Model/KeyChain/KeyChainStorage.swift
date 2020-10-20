//
//  KeyChainStorage.swift
//  CSAPITask
//
//  Created by Aleksandr on 04/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit

struct KeyChainStorage {
    
    enum KeyChainStorageError: Error {
        case cannotAddItem
        case cannotFindItem
        case cannotUpdateItem
        case cannotDeleteItem
    }
    
    private let tag: Data
    
    private init(tag: Data) {
        self.tag = tag
    }
    
    static func keychainStorage(tag: String) -> KeyChainStorage? {
        guard let data = tag.data(using: .utf8) else {
            return nil
        }
        return KeyChainStorage(tag: data)
    }
    
    func add(item: Data) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                    kSecAttrApplicationTag as String: tag,
                                    kSecValueData as String: item]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess else {
            throw KeyChainStorageError.cannotAddItem
        }
    }
    
    func find() throws -> Data {
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                    kSecAttrApplicationTag as String: tag,
                                    kSecReturnData as String: true]
        
        var item: CFTypeRef?
        
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard
            status == errSecSuccess,
            let result = item as? NSData
            else {
            throw KeyChainStorageError.cannotFindItem
        }
        
        let itemData = Data(referencing: result)
        
        return itemData
    }
    
    private func complete(_ status: OSStatus) throws {
        switch status {
        case errSecSuccess:
            return
        case errSecItemNotFound:
            throw KeyChainStorageError.cannotFindItem
        default:
            throw KeyChainStorageError.cannotUpdateItem
        }
    }
    
    func update(item: Data) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                    kSecAttrApplicationTag as String: tag]
        
        let attributes: [String: Any] = [kSecValueData as String:item]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        try complete(status)
    }
    
    func delete() throws {
        let query: [String: Any] = [kSecClass as String: kSecClassKey,
                                    kSecAttrApplicationTag as String: tag]
        
        let status = SecItemDelete(query as CFDictionary)
        
        try complete(status)
    }
}
