//
//  ChatViewController.swift
//  chat
//
//  Created by Sandesh Basnet on 9/26/18.
//  Copyright © 2018 Sandesh Basnet. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatText: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    var messages: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.messages.count
        
        
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let message = self.messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
         cell.chatMessage.text = message["message"] as! String
    
        return cell
    }
    
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        
           postMessage(self.chatText.text)
           getData()
    }
    
    @objc func onTimer() {
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }
    
    func getData() {
        
        let url = URL(string: "https://parkistan.herokuapp.com/messages")!
        
        let request = URLRequest(url:url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {
            
            (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
                
            else if let data = data {
                
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                
               self.messages = dataDictionary
                self.tableView.reloadData()
              
            }
        }
        
        task.resume()
       
    }
    
    func postMessage(_ message: String!) {
        
        let url = URL(string: "https://parkistan.herokuapp.com/update")!
        
        var request = URLRequest(url:url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let postString = "message=\(chatText.text!)"
        request.httpBody = postString.data(using: .utf8)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) {
            
            (data, response, error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
                
            
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
            
        }
        
        task.resume()
    }
    


}
