//
//  ChatViewController.swift
//  ChattingApp
//
//  Created by Lola M on 12/7/21.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var arrOfMsgs: [Msg] = []
    let fireStoreURL = Firestore.firestore()
    var theMsg: [String : Any]?
    
//    var id: String?
//    var name: String?
    
//    var currentUser: User?
//    var currentMsg: Msg?
    
    var myID: String?
    var userId: String?
    var userName: String?
    
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tf: UITextField!
    
    @IBOutlet weak var btnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView2.delegate = self
        tableView2.dataSource = self
        
        myID = Auth.auth().currentUser!.uid
        
        print("*******************************")
        print("*******************************")
        print("*******************************")
        print("*******************************")
//        print(currentUser)
        print("*******************************")
        print("*******************************")
        print("*******************************")
        print("*******************************")
        
    }
    
    
    
    @IBAction func sendBtnAction(_ sender: Any) {
        sendFunc()
        tf.text = ""
    }
    
    
    func sendFunc() {
        theMsg = [
            "userID": myID,
            "date": dateSended(),
            "content": tf.text!
        ]
        
        fireStoreURL.collection("Users").document(myID!).collection("Messages").document(userId!).collection("msg").document().setData(theMsg!)
        
        fireStoreURL.collection("Users").document(userId!).collection("Messages").document(myID!).collection("msg").document().setData(theMsg!)
        reloadAllMsg(idUser: userId!)
    }
    
    func dateSended() -> String {
        let format = DateFormatter()
        format.dateFormat = "dd/mm/yyyy hh:mm:ss a"
        let date = format.string(from: Date())
        return date
    }
    
    
    func reloadAllMsg(idUser: String) {
        arrOfMsgs.removeAll()
    
        fireStoreURL.collection("Users").document(myID!).collection("Chat").document(self.userId!).collection("Message").order(by: "date").addSnapshotListener { snapShot, error in
            self.arrOfMsgs.removeAll()
            print("_+_+_+_+_+_+")
    
            for x in snapShot!.documents {
                print(x.documentID)
                print("content", x.get("content")!)
                
                let id = x.get("id") as! String
                let content = x.get("content")! as! String
                self.arrOfMsgs.append(Msg(id: id, content: content))
    
            }
            self.tableView2.reloadData()
        }
    }
    
}


extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfMsgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView2.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as! MYTableViewCell2
        cell.name.text = userName
        cell.msg.text = arrOfMsgs[indexPath.row].content
        
        return cell
    }
}
