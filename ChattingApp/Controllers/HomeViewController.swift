//
//  HomeViewController.swift
//  ChattingApp
//
//  Created by Lola M on 12/7/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var arrOfUsers: [User] = []
    let firestoreURL = Firestore.firestore()
    
//    var sendedId = ""
//    var sendedName = ""
    var currentUser: User?
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsersFromFirestore()
        
        print("*******************************")
        print("*******************************")
        print("*******************************")
        print("*******************************")
        print(currentUser)
        print("*******************************")
        print("*******************************")
        print("*******************************")
        print("*******************************")

    }
    
    @IBAction func signout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print(error)
        }
    }
    
    
    func getUsersFromFirestore() {
        firestoreURL.collection("Users").getDocuments { snapShot, error in
            for user in snapShot!.documents {
//                print(user.get(id))
                let name = user.get("name") as! String
                let id = user.get("id") as! String
                self.currentUser = User(id: id, name: name)
                self.arrOfUsers.append(self.currentUser!)

                
//                self.arrOfUsers.append(User(id: id, name: name))
            }
            self.myTableView.reloadData()
        }
    }
    
}
    


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
//        cell.label.text = arrOfUsers[indexPath.row].name
        cell.label.text = arrOfUsers[indexPath.row].name
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        sendedId = arrOfUsers[indexPath.row].id
//        sendedName = arrOfUsers[indexPath.row].name
        currentUser = arrOfUsers[indexPath.row]
        performSegue(withIdentifier: "homeToChat", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = ChatViewController()
        if segue.identifier == "homeToChat" {
//            vc.id = sendedId
//            vc.name = sendedName
            vc.userName = currentUser?.name
        }
    }
}
