//
//  ViewController.swift
//  ContactList
//
//  Created by Selasi Afi Gborglah on 19/07/2019.
//  Copyright © 2019 Subash. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    final let urlString = "https://randomuser.me/api?seed=rambhatla&results=10"
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray = [String]()
    var emailArray = [String]()
    var imgURLArray = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Json()
    }
    
    func Json() {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj.value(forKey: "results"))
                
                if let actorArray = jsonObj.value(forKey: "results") as? NSArray {
                    for actor in actorArray{
                        if let actorDict = actor as? NSDictionary {
                            if let namedict = actorDict.value(forKey: "name") {
                                if let name = (namedict as AnyObject).value(forKey: "first"){
                                    self.nameArray.append(name as! String)
                                    print(name)
                                }
                                
                                
                            }
                            if let name = actorDict.value(forKey: "email") {
                                self.emailArray.append(name as! String)
                                print(name)
                            }
                            if let namedict = actorDict.value(forKey: "picture") {
                                if let name = (namedict as AnyObject).value(forKey: "thumbnail"){
                                    self.imgURLArray.append(name as! String)
                                    print(name)
                                }
                                
                                
                            }
                            
                        }
                    }
                }
                
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
                
        }).resume()
            
    }
    
    
    func JsonTask() {
        
        let url = URL(string: urlString)
        
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            
            print(jsonData)
            
        }).resume()
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.nameLabel.text = nameArray[indexPath.row]
        cell.emailLabel.text = emailArray[indexPath.row]
        
        let imgURL = URL(string: imgURLArray[indexPath.row])
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.imgView.image = UIImage(data: data! as Data)
            cell.imgView.layer.cornerRadius = 20
            cell.imgView.clipsToBounds = true
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView" {
            let detailVC: DetailViewController = (segue.destination as? DetailViewController)!
            let cell: UITableViewCell? = sender as? UITableViewCell
            }
        }
    
}
