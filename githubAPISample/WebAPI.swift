//
//  WebAPI.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Alamofire


class WebAPI {
    
    static func get() {
        Alamofire.request("https://api.github.com/events").responseJSON { (response) in
            print("Request" + String(describing: response.result))
            print("Request" + String(describing: response.response))
            if let json = response.result.value {
                print("JSON: \(json)")
            }
        }
    }
}


//
//typealias Input = Request
//
//typealias Request = (
//    url: URL,
//    queries: [URLQueryItem],
//    headers: [String: String],
//    methodAndPayload: HTTPMethodAndPayload
//)
//
//enum HTTPMethodAndPayload {
//    case get
//    var method: String {
//        switch self {
//        case .get:
//            return "GET"
//        }
//    }
//
//    var body: Data? {
//        switch self {
//        case .get:
//            return nil
//        }
//    }
//}
//
//
//
