//
//  ViewController.swift
//  FileManager
//
//  Created by 辛忠翰 on 2018/12/7.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let testImgView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        var dogs = [Dog]()
//        
//        let dog1 = Dog.init(name: "GG1", owner: "GG1")
//        let dog2 = Dog.init(name: "GG3", owner: "GG3")
//        dogs.append(dog1)
//        dogs.append(dog2)
        
//        let fileManager = FileManager()
//        guard let url = fileManager.fetchPath(directory: .tmp, fileName: "myJson", fileExtension: "json") else {return}
//        try? fileManager.parseObjectToJsonAndSave(object: dogs, at: url) { (json) in
//            print(json)
//        }
        
//        try? fileManager.parseJsonToObject(type: [Dog].self, at: url, completionHandler: { (dog) in
//            print(dog)
//        })
        
//        try? fileManager.contentsOfDirectoryAtPath(at: fileManager.fetchPath(directory: .tmp)!)
    }


}


class Dog: Codable{
    var name: String
    var owner: String
    init(name: String, owner: String) {
        self.name = name
        self.owner = owner
    }
}
