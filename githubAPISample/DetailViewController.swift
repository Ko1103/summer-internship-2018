
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
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var followURLLabel: UILabel!
    @IBOutlet private weak var followedURLLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "詳細"
        DispatchQueue.global().async {
            if let targetURL = self.targetURL {
                Alamofire.request(targetURL).responseJSON { (response) in
                    guard let data = response.result.value else { return }
                    print(data)
                    let jsonData = JSON(data)
                    DispatchQueue.main.async {
                        self.idLabel.text = "name: " + jsonData["name"].description
                        self.followURLLabel.text = "language: " + jsonData["language"].rawString()!
                        self.followedURLLabel.text = "network:  " + jsonData["network_count"].rawString()!
                    }
                }
            }
        }
    }
}
