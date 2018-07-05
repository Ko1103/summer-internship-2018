//
//  Repo.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation


struct Event: Codable {
    var id: String
    var type: String
    var actor: Actor
    var repo: Repo
    var payload: Payload
    var publicStatus: Bool
    var created_at: String
    
    private enum CodingKeys: String, CodingKey {
        case publicStatus = "public"
    }
}

struct Actor {
    var id: Int
    var login: String
    var display_login: String
    var gravatar_id: String
    var url: String
    var avatar_url: String
}

struct Repo: Codable {
    var id: Int
    var name: String
    var url: String
}

struct Payload: Codable {
    var ref: String?
    var ref_type: String
    var master_branch: String
    var description: String
    var pusher_type: String
}

