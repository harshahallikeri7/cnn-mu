//
//  MUUserDefaultsKeys.swift
//  MobileUserConsent
//
//  Created by Manoj K Malvi on 29/08/22.
//

//
//  AppUserDefault.swift
//  SetupApp
//


import Foundation


let AppUserDefaults = UserDefaults.standard

/**
 ```
Example :
Defaults[.version] = "addasdsaad adssadsad"
print(Defaults[.version] ?? "")
```
*/

public struct UserDefaultsKey<T> {
    let value: String
    let returnType: T.Type
}


struct UserDefaultsKeys {
    static let testKey   = UserDefaultsKey(value: "testKey", returnType: String.self)
}


extension UserDefaults {
    
    func setValue<T>(value: T, forKey key: UserDefaultsKey<T>) {
        setValue(value, forKey: key.value)
        synchronize()
    }
    
    func value<T>(forKey key: UserDefaultsKey<T>) -> T? {
        if let value = object(forKey: key.value) as? T {
            return value
        }
        return nil
    }
    
    func clearValue<T>(forKey key: UserDefaultsKey<T>) {
        removeObject(forKey: key.value)
        synchronize()
    }
}




