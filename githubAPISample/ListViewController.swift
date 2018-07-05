//
//  ViewController.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Alamofire

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var repos:[Event] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            Alamofire.request("https://api.github.com/events").responseJSON { (response) in
                print(response.result.value)
                if let data = response.data {
                    let decoder: JSONDecoder = JSONDecoder()
                    do {
                        let newRepos = try decoder.decode([Event].self, from: data)
                        print(newRepos)
                        self.repos = newRepos
                    } catch {
                        print("fatal to get Repos")
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("画面遷移")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ""
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
}

