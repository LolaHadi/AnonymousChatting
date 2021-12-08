//
//  ViewController.swift
//  ChattingApp
//
//  Created by Lola M on 12/7/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let fireStoreURL = Firestore.firestore()
    
    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func letsChatBtnAction(_ sender: Any) {
        if Auth.auth().currentUser?.uid == nil {
            Auth.auth().signInAnonymously { user, error in
                if error == nil {
                    let userData = ["name": self.tf.text!,
                                    "id": user?.user.uid]
                    self.fireStoreURL.collection("Users").document()
                    self.fireStoreURL.collection("Users").document((user?.user.uid)!).setData(userData)
                }
            }
        } else {
            performSegue(withIdentifier: "btnToHome", sender: self)
        }
    }
}
