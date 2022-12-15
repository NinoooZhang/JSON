//
//  Models.swift
//  JSONTests
//
//  Created by Nino Zhang on 2022/12/15.
//

import Foundation
import SwiftyJSON
import JASON
import ObjectMapper
import HandyJSON

struct SimpleModel {
    let id: Int
    let name: String
    let friends: [String]
    let edu: [String: String]
    let likes: [String: Bool]
}

// JASON
extension SimpleModel {
    init(jasonJSON json: JASON.JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        friends = json["friends"].jsonArrayValue.map { $0.stringValue }
        edu = json["edu"].jsonDictionaryValue.mapValues {  $0.stringValue }
        likes = json["likes"].jsonDictionaryValue.mapValues { $0.boolValue }
    }
}

// SwiftyJSON
extension SimpleModel {
    init(swiftyJSON json: SwiftyJSON.JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        friends = json["friends"].arrayValue.map { $0.stringValue }
        edu = json["edu"].dictionaryValue.mapValues {  $0.stringValue }
        likes = json["likes"].dictionaryValue.mapValues { $0.boolValue }
    }
}

// ObjectMapper
struct ObjectMapperModel: Mappable {
    var id: Int?
    var name: String?
    var friends: [String]?
    var edu: [String: String]?
    var likes: [String: Bool]?

    init?(map: Map) { }
    mutating func mapping(map: Map) {
        id      <-  map["id"]
        name    <-  map["name"]
        friends <-  map["friends"]
        edu     <-  map["edu"]
        likes   <-  map["likes"]
    }
}

// HandyJSON
struct HandyModel: HandyJSON {
    var id: Int?
    var name: String?
    var friends: [String]?
    var edu: [String: String]?
    var likes: [String: Bool]?
}

// Codable
extension SimpleModel: Codable { }
