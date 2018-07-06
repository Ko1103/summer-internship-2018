//
//  APIConfiguration.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/07.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}
