//
//  FileManager_Extension.swift
//  FileManager
//
//  Created by 辛忠翰 on 2018/12/7.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
public extension FileManager{
    
    //fetch path of directory with file name
    public func fetchPath(directory: Directory, fileName: String, fileExtension: String) -> URL?{
        return directory.fetchUrl(fileManager: self, fileName: fileName + "." + fileExtension)
    }
    
    //fetch path of directory
    public func fetchPath(directory: Directory) -> URL?{
        return directory.fetchUrl(fileManager: self)
    }
    
    //write text to disk
    public func write(text: String, to filePathUrl: URL) throws{
        try text.write(to: filePathUrl, atomically: true, encoding: .utf8)
    }
    
    //read text from disk
    public func readText(to filePathUrl: URL) throws -> String?{
        return try String(contentsOf: filePathUrl, encoding: .utf8)
    }
    
    //copy image from bundle path to directory path
    public func copyImgToDisk(imgName: String, fileExtension: String, to filePathUrl: URL)throws {
        guard let bundleUrl = Bundle.main.url(forResource: imgName, withExtension: fileExtension) else {return}
        try copyItem(at: bundleUrl, to: filePathUrl)
    }
    
    //get image from bundle path
    public func fetchImgaePathInTheBundle(imgName: String, fileExtension: String)throws -> UIImage?{
        guard let bundleUrl = Bundle.main.url(forResource: imgName, withExtension: fileExtension) else {return nil}
        let imageData = try Data(contentsOf: bundleUrl)
        let image = UIImage(data: imageData)
        return image
    }
    
    
    //save image to disk
    public func write(image: UIImage, to filePathUrl: URL) throws{
        let data = image.jpegData(compressionQuality: 1.0)
        try data?.write(to: filePathUrl, options: .atomic)
    }
    
    //read image from disk
    public func readImage(to filePathUrl: URL) throws -> UIImage?{
        return try UIImage(data: Data(contentsOf: filePathUrl))
    }
    
    //create directory at path
    public func createDirectoryAtPath(at filePathUrl: URL, directory name: String) throws{
        let pathUrl = filePathUrl.appendingPathComponent(name)
        //withIntermediateDirectories:此參數為true時，將會在創建目標文件夾前，創建所有的中間文件夾
        //attributes:傳遞影響文件夾創建行為屬性的字典給系統，如修改創建日期、時間等
        try createDirectory(at: pathUrl, withIntermediateDirectories: true, attributes: nil)
    }
    
    //遍尋某個目錄下的所有的文件夾by string file path
    public func contentsOfDirectoryAtPath(at filePath: String) throws -> [String]{
        let contents = try contentsOfDirectory(atPath: filePath)
        if !contents.isEmpty{
            for content in contents{
                print(content)
            }
        }
        return contents
        
    }
    
    //遍尋某個目錄下的所有的文件夾by url file path
    public func contentsOfDirectoryAtPath(at filePathUrl: URL)throws -> [URL]{
        let contents = try contentsOfDirectory(at: filePathUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        if !contents.isEmpty{
            for content in contents{
                print(content.lastPathComponent)
            }
        }
        return contents
    }
    
    //遍尋在.app此層下的所有內容
    public func contentsOfAppBundle() throws -> [URL]{
        let propertiesToGet = [
            URLResourceKey.isDirectoryKey,
            URLResourceKey.isReadableKey,
            URLResourceKey.creationDateKey,
            URLResourceKey.contentAccessDateKey,
            URLResourceKey.contentModificationDateKey,
        ]
        let bundleUrl = Bundle.main.bundleURL
        let result = try contentsOfDirectory(at: bundleUrl, includingPropertiesForKeys: propertiesToGet, options: .skipsHiddenFiles) as [URL]
        return result
    }
    
    public func printUrlProperties(url: URL){
        print("URL name: \(url.lastPathComponent) \n")
        print("Is a directory: \(url.isUrlDirectory ?? false) \n")
        print("Is readable: \(url.isUrlReadable ?? false) \n")
        print("Creation date: \(url.creationDate ?? Date()) \n")
        print("Access date: \(url.accessDate ?? Date()) ")
        print("Modify date: \(url.modifycationDate ?? Date())  \n")
        print("---------------------------")
    }
    
    //產生n個txt檔案在某個directory中
    public func generateTxtFiles(atPath filePathUrl: URL, of number: Int ) throws{
        for index in 0 ... number{
            let fileName = String(format: "%lu.txt", index)
            let path = filePathUrl.appendingPathComponent(fileName)
            let fileContent = "Some texts...\(index)"
            try fileContent.write(to: path, atomically: true, encoding: .utf8)
            
        }
    }
    
    //產生n個檔案在某個directory中
    public func generateFiles(atPath filePathUrl: URL, of number: Int, extension name: FileType, text: String? = nil, image: UIImage? = nil) throws{
        for index in 0 ... number{
            let fileName = String(format: "%lu.\(name)", index)
            let path = filePathUrl.appendingPathComponent(fileName)
            try name.write(atPath: path, fileManager: self, text: text, image: image)
        }
    }
    
    
    public func deleteAllFiles(atPath directoryPathUrl: URL)throws{
        let contents = try contentsOfDirectoryAtPath(at: directoryPathUrl)
        print(contents.count)
        for content in contents{
            try removeItem(at: content)
        }
    }
    
    public func deleteFile(atPath directoryPathUrl: URL, fileName: String)throws{
        let filePath = directoryPathUrl.appendingPathComponent(fileName)
        try removeItem(at: filePath)
    }
    
    public func parseObjectToJsonAndSave<T: Codable>(object: T, at filePathUrl: URL?, completionHandler: (_ json: String)->())throws {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(object)
        guard let filePathUrl = filePathUrl else {return}
        try jsonData.write(to: filePathUrl, options: .atomic)
        guard let json = String(data: jsonData, encoding: .utf8) else {return}
        completionHandler(json)
    }
    
    public func parseJsonToObject<T: Codable>(type: T.Type, at filePathUrl: URL, completionHandler: (_ object: Codable)->())throws {
        let data = try Data(contentsOf: filePathUrl, options: .alwaysMapped)
        let jsonDecoder = JSONDecoder()
        let object = try jsonDecoder.decode(type.self, from: data)
        completionHandler(object)
        
    }
}

public extension URL{
    var isUrlDirectory: Bool?{
        return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory
    }
    
    var isUrlReadable: Bool?{
        return (try? resourceValues(forKeys: [.isReadableKey]))?.isReadable
    }
    
    var creationDate: Date?{
        return (try? resourceValues(forKeys: [.creationDateKey]))?.creationDate
    }
    
    var accessDate: Date?{
        return (try? resourceValues(forKeys: [.contentAccessDateKey]))?.contentAccessDate
    }
    
    var modifycationDate: Date?{
        return (try? resourceValues(forKeys: [.contentModificationDateKey]))?.contentModificationDate
    }
}



public enum Error: String, Swift.Error{
    case failedWritten
}

public enum Directory: String, CaseIterable{
    case document
    case library
    case cache
    case tmp

    public func fetchUrl(fileManager: FileManager) -> URL?{
        switch self {
        case .document:
            return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        case .library:
            return fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first
        case .cache:
            return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
        case .tmp:
            return URL(fileURLWithPath: NSTemporaryDirectory())
        }
    }
    
    public func fetchUrl(fileManager: FileManager, fileName: String) -> URL?{
        switch self {
        case .document:
            return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
        case .library:
            return fileManager.urls(for: .libraryDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
        case .cache:
            return fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(fileName)
        case .tmp:
            return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        }
    }
    
   
}


public enum FileType: String, CaseIterable{
    case txt
    case PNG
    case JPEG
    
    public func write(atPath path: URL, fileManager: FileManager, text: String? = nil, image: UIImage? = nil)throws {
        switch self {
        case .txt:
            guard let text = text else {return}
            try fileManager.write(text: text, to: path)
        case .PNG:
            guard let image = image else {return}
            try fileManager.write(image: image, to: path)
        case .JPEG:
            guard let image = image else {return}
            try fileManager.write(image: image, to: path)
        }
    }
}
