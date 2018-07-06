//
//  ViewController.swift
//  githubAPISample
//
//  Created by 山浦功 on 2018/07/05.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var repos: [Repo] = []
    private var users: [User] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            let router = APIRouter.users
            let request = try! router.asURLRequest()
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let jsonData = try! decoder.decode([User].self, from: data!)
                    self.users = jsonData
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }).resume()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = self.repos[indexPath.row].url
        self.performSegue(withIdentifier: "detail", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = self.users[indexPath.row]
        cell.textLabel?.text = String(data.id)
        cell.detailTextLabel?.text = data.login
//        let data = self.repos[indexPath.row]
//        cell.textLabel?.text = String(data.id)
//        cell.detailTextLabel?.text = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let next: DetailViewController = segue.destination as! DetailViewController
            next.targetURL = sender as! String
        }
        
    }
}

