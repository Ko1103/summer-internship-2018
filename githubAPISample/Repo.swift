//
//  Repo.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation


//struct Event: Codable {
//    var id: String
//    var type: String
//    var actor: Actor
//    var repo: Repo
//    var payload: Payload
//    var publicStatus: Bool
//    var createdAt: String
//}

struct Actor {
    var id: Int
    var login: String
    var displayLogin: String
    var gravatarId: String
    var avatarUrl: String
    var url: String
}

struct Repo: Codable {
    var id: Int
    var name: String
    var url: String
}

struct Payload: Codable {
    var ref: String?
    var refType: String
    var masterBranch: String
    var description: String
    var pusherType: String
}

