//
//  JSONDecoder_Extension.swift
//  FileManager
//
//  Created by 辛忠翰 on 2018/12/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation

public extension JSONDecoder{
    public func decodingJSON<T: Codable>(type: T.Type, jsonData: Data)throws -> T {
        let object = try decode(type.self, from: jsonData)
        return object
    }
    
    public func decodingJSON<T: Codable>(type: T.Type, jsonData: Data, completionHandler: (_ object: T) -> ())throws {
        let object = try decode(type.self, from: jsonData)
        completionHandler(object)
    }
}
