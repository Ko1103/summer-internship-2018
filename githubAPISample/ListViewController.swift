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
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            Alamofire.request("https://api.github.com/events").responseJSON { (response) in
                guard let data = response.result.value else { return }
                let jsonData = JSON(data)
                jsonData.forEach({ (_, json) in
                    let decoder = JSONDecoder()
                    do {
                        let repo = try? decoder.decode(Repo.self, from: json["repo"].rawData())
                        self.repos.append(repo!)
                    } catch {
                        print("fail to get data")
                    }
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sender = self.repos[indexPath.row].url
        self.performSegue(withIdentifier: "detail", sender: sender)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = self.repos[indexPath.row]
        cell.textLabel?.text = String(data.id)
        cell.detailTextLabel?.text = data.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let next: DetailViewController = segue.destination as! DetailViewController
            next.targetURL = sender as! String
        }
        
    }
}

