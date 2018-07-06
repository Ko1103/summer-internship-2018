
//
//  DetailViewController.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//
class DetailViewController: UIViewController {

    var targetURL: String?
    var name: String?
    var user: User?
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var followURLLabel: UILabel!
    @IBOutlet private weak var followedURLLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "詳細"
        DispatchQueue.global().async {
            if let name = self.name {
                let router = APIRouter.user(name: name)
                let request = try! router.asURLRequest()
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error == nil {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        self.user = try! decoder.decode(User.self, from: data!)
                        DispatchQueue.main.async {
                            if let user = self.user {
                                self.idLabel.text = "ID: " + String(user.id)
                                self.followURLLabel.text = "名前：" + user.login
                                self.followedURLLabel.text = "フォロワー" + user.followersUrl
                            }
                        }
                    }
                }).resume()
            }
            
//            if let targetURL = self.targetURL {
//                Alamofire.request(targetURL).responseJSON { (response) in
//                    guard let data = response.result.value else { return }
//                    print(data)
//                    let jsonData = JSON(data)
//                    DispatchQueue.main.async {
//                        self.idLabel.text = "name: " + jsonData["name"].description
//                        self.followURLLabel.text = "language: " + jsonData["language"].rawString()!
//                        self.followedURLLabel.text = "network:  " + jsonData["network_count"].rawString()!
//                    }
//                }
//            }
        }
    }
}
