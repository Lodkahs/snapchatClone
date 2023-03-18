//
//  FeedVC.swift
//  SnapchatClone
//
//  Created by Andrew  on 3/16/23.
//

import UIKit
import Firebase

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let firestoreDatabase = Firestore.firestore()
    var snapArray = [Snap]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getSnapsFromFirestore()

        getUserInfo()
    }
    
    func getSnapsFromFirestore() {
        
        firestoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.snapArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String{
                            
                            if let imageUrlArray = document.get("imageURLArray") as? [String] {
                                
                                if let date = document.get("date") as? Timestamp {
                                    
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        
                                        if difference >= 24 {
                                            //delete document
                                            self.firestoreDatabase.collection("Snap").document(documentId).delete { error in
                                                //
                                            }
                                        } else {
                                            //time left to delete
                                        }
                                        
                                    }
                                    
                                    let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    
                                    self.snapArray.append(snap)
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    func getUserInfo() {
        
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { snapshot, error in
            
            if error != nil {
                
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                
            } else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                        if let username = document.get("username") as? String {
                            UserSingleton.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSingleton.sharedUserInfo.username = username
                        }
                        
                        
                    }
                }
                
            }
        }
        
        
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.feedLabel.text = snapArray[indexPath.row].username
        return cell
    }
    


}
