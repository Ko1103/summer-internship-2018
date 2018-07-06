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
    
    static let baseURL = "https://api.github.com/"
    
    static func get(path: String) {
        var data: Data? = nil
        Alamofire.request("https://api.github.com/events" + "path").responseJSON { (response) in
            print("Request" + String(describing: response.result))
            print("Request" + String(describing: response.response))
            if let json = response.result.value {
                print("JSON: \(json)")
            }
            data = response.data
        }
    }
}

enum APIRouter: URLRequestConvertible {
    
    case users
    case user(name: String)
    case repo(id: String)
    
    private var method: HTTPMethod {
        switch self {
        case .users:
            return .get
        case .user:
            return .get
        case .repo:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .users:
            return "/users"
        case .user(let name):
            return "/users/\(name)"
        case .repo(let id):
            return "/repos/\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        return urlRequest
    }
}
