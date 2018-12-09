//
//  JSONEncoder_Extension.swift
//  FileManager
//
//  Created by 辛忠翰 on 2018/12/9.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation


public extension JSONEncoder{
    public func encodingObject<T: Encodable>(object: T)throws -> String? {
        let jsonData = try encode(object)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        return json
    }
    
    public func encodingObject<T: Encodable>(object: T, completionHandler: (_ json: String) -> ())throws{
        let jsonData = try encode(object)
        guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else {return}
        completionHandler(json)
    }
    
    public func encodingObject<T: Encodable>(object: T, completionHandler: (_ jsonData: Data, _ json: String) -> ())throws{
        let jsonData = try encode(object)
        guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else {return}
        completionHandler(jsonData, json)
    }
}
