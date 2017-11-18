//
//  ImageClass.swift
//  Grocery
//
//  Created by Melody on 11/6/17.
//  Copyright © 2017 Melody Yang. All rights reserved.
//

import Foundation
import Gloss


struct Classes: Glossy, Codable {
//    var classValue: String?
//    var custom_classes: Int?
    var score: Float?

    init?(json: JSON) {
//        self.custom_classes = "custom_classes" <~~ json
        
//        guard let classValue: String = "custom_classes" <~~ json else {return}
        
//        self.classValue = "custom_classes" <~~ json
        self.score = "score" <~~ json
    }

    func toJSON() -> JSON? {
        return jsonify([
            ])
    }

}


struct ClassValue : Glossy, Codable {
    var classValue: [Classes]
    
    init?(json: JSON) {
        guard let classValue: [Classes] = "classes" <~~ json
            else { print("Error decoding classes Array");  return nil }
        self.classValue = classValue
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            ])
    }
}

struct Classifiers: Glossy, Codable {
    var classifier: [ClassValue]
    
    init?(json: JSON) {
        guard let classifier: [ClassValue] = "classifiers" <~~ json
            else { print("Error decoding classifier Array"); return nil }
        self.classifier = classifier
    }
    
    func toJSON() -> JSON? {
        return jsonify([
       
            ])
    }
    
}

struct Images: Glossy, Codable {
    
    let images: [Classifiers]
    
    init?(json: JSON) {
        guard let images: [Classifiers] = "images" <~~ json
            else { print("Error decoding Images Array"); return nil}
   
        
        self.images = images
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            
            ])
    }
}


//
//struct ImageClass: Codable {
//    var classValue: String?
//
//    init(classValue: String) {
//        self.classValue = classValue
//    }
//
//}


//struct ImageClass: Codable {
////    var class_ : String
//    var class_: String
////
//    struct Class: Codable {
//        var class_: String
//
//        enum CodingKeys: String, CodingKey {
//            case class_ = "class"
//        }
//    }
////    init(class_: String) {
////        self.class_ = class_
////    }
//}
//
//
//
//struct ImageClassService: Codable {
//    var images: [Classifiers]
//
//    struct Classifiers: Codable {
//        var classifiers: [Classes]
//
//    struct Classes: Codable {
//        var class_: String
//
//        enum CodingKeys: String, CodingKey {
//            case class_ = "class"
//        }
//    }
//}
//}


//
//struct List: Codable {
//    let list: [ImageClass]
//}
//
//
//extension ImageClass {
//    init(from service: ImageClassService) {
////        class_ = []
//
//        for classifier in service.images {
//            for clas in classifier.classifiers{
//                class_ = clas.class_
//            }
//        }
//         self.init(class_: class_)
//    }
//
//}


//struct Classifier: Codable {
//    let classifier: [ImageClass]
//}
//
//struct Classes: Codable {
//    let classe: [Classifier]
//}

//extension ImageClass {
//
//    enum ClassifierKeys: String, CodingKey {
//        case classes
//    }
//
//    enum ClassKeys: String, CodingKey {
//        case class_ = "class"
//    }
//
//     init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: ClassifierKeys.self)
//        let classContainer = try container.nestedContainer(keyedBy: ClassKeys.self, forKey: .classes)
//
//        let classValue: String = try classContainer.decode(String.self, forKey: .class_)
//
//        self.init(classValue: classValue)
//
//    }
//
//
//}


