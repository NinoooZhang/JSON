//
//  JSONTests.swift
//  JSONTests
//
//  Created by Nino Zhang on 2022/12/15.
//

import XCTest
@testable import JSON

import JASON
import SwiftyJSON
import ObjectMapper
import HandyJSON


final class JSONTests: XCTestCase {

    let data = loadData()
    let times = 10000

    func testJASON() throws {
        measure {
            for _ in 0..<times {
                let json = JASON.JSON(data)
                _ = SimpleModel(jasonJSON: json)
            }
        }
    }

    func testSwiftyJSON() throws {
        measure {
            for _ in 0..<times {
                let json = SwiftyJSON.JSON(data)
                _ = SimpleModel(swiftyJSON: json)
            }
        }
    }

    func testObjectMapper() throws {
        measure {
            for _ in 0..<times {
                let JSONString = String(data: data, encoding: .utf8)!
                _ = ObjectMapperModel(JSONString: JSONString)
            }
        }
    }

    func testHandyJSON() throws {
        measure {
            for _ in 0..<times {
                let JSONString = String(data: data, encoding: .utf8)!
                _ = HandyModel.deserialize(from: JSONString)
            }
        }
    }

    func testCodable() throws {
        let decoder = JSONDecoder()
        measure {
            for _ in 0..<times {
                _ = try? decoder.decode(SimpleModel.self, from: data)
            }
        }
    }
}

private func loadData() -> Data {
    let path = Bundle.main.path(forResource: "SimpleResp", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .uncached)
    return data
}
