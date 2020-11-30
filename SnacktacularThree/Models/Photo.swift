//
//  Photo.swift
//  SnacktacularThree
//
//  Created by James Monahan on 11/16/20.
//

import UIKit
import Firebase

class Photo {
    var image: UIImage
    var description: String
    var photoUserID: String
    var photoUserEmail: String
    var date: Date
    var photoURL: String
    var documentID:String
    
    var dictionary: [String: Any]{
        let timeIntervalDate = date.timeIntervalSince1970
        return ["description": description, "photoUserID": photoUserID,
                "photoUserEmail": photoUserEmail, "data": timeIntervalDate, "photoURL": photoURL]
    }
    
    init(image: UIImage, description: String, photoUserID: String, photoUserEmail: String, date: Date, photoURL: String, documentID:String){
        self.image = image
        self.description = description
        self.photoUserID = photoUserID
        self.photoUserEmail = photoUserEmail
        self.date = date
        self.photoURL = photoURL
        self.documentID = documentID
    }

    
    convenience init(){
        let photoUserID = Auth.auth().currentUser?.uid ?? ""
        let photoUserEmail = Auth.auth().currentUser?.email ?? "unknown email"
        self.init(image: UIImage(), description: "", photoUserID: photoUserID, photoUserEmail: photoUserEmail, date: Date(), photoURL: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let description = dictionary["description"] as! String? ?? ""
        let photoUserID = dictionary["photoUserID"] as! String? ?? ""
        let photoUserEmail = dictionary["photoUserEmail"] as! String? ?? ""
        let timeIntervalDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
        let date = Date(timeIntervalSince1970: timeIntervalDate)
        let photoURL = dictionary["photoURL"] as! String? ?? ""
    
        self.init(image: UIImage(), description: description, photoUserID: photoUserID, photoUserEmail: photoUserEmail, date: date, photoURL: photoURL, documentID: "")
        }
    
    func saveData(spot: Spot, completion: @escaping (Bool) -> ()) {
            let storage = Storage.storage()

            guard let photoData = self.image.jpegData(compressionQuality: 0.5) else {
                print("Error: Could not convert photo.image to Data.")
                return
            }
            let uploadMetaData = StorageMetadata()
            uploadMetaData.contentType = "image/jpeg"
            if documentID == "" {
                documentID = UUID().uuidString
            }
            
            let storageRef = storage.reference().child(spot.documentID).child(documentID)
            let uploadTask = storageRef.putData(photoData, metadata: uploadMetaData) { (metadata, error) in
                if let error = error {
                    print("Error: upload for ref \(uploadMetaData) failed. \(error.localizedDescription)")
                }
            }
            uploadTask.observe(.success) { (snapshot) in
                print("Upload to Firebase Storage was successful!")
                storageRef.downloadURL {(url, error) in
                    guard error == nil else {
                        print("Error: Couldn't create a download url \(error.localizedDescription)")
                        return completion(false)
                    }
                    guard let url = url else {
                        print("Error: url was nill and this should not have happened because we've already shown there was no error.")
                        return completion(false)
                    }
                    self.photoURL = "\(url)"
                    let db = Firestore.firestore()
                    let dataToSave: [String: Any] = self.dictionary
                    let ref = db.collection("spots").document(spot.documentID).collection("photos").document(self.documentID)
                    ref.setData(dataToSave) { (error) in
                        guard error == nil else {
                            print("😡 ERROR: updating document \(error!.localizedDescription)")
                            return completion(false)
                        }
                        print("💨 Updated document: \(self.documentID) in spot: \(spot.documentID)") // It worked!
                        completion(true)
                    }
                }
                
            }
            uploadTask.observe(.failure){ (snapchot) in
                if let error = snapchot.error{
                    print("Eror: upload task for file \(self.documentID) failed, in spot \(spot.documentID), with error \(error.localizedDescription)")
                }
                completion(false)
            }
    }
    
    func loadImage(spot: Spot, completion: @escaping(Bool) -> ()){
        guard spot.documentID != "" else{
            print("Error: did not pass a valid spit into loadImage")
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference().child(spot.documentID).child(documentID)
        storageRef.getData(maxSize: 25 * 1024 * 1024){(data, error) in
            if let error = error {
                print("Error: an error occurred while reading data from file ref:\(storageRef) error = \(error.localizedDescription)")
                return completion(false)
            } else {
                self.image = UIImage(data: data!) ?? UIImage()
                return completion(true)
            }
        }
    }
}
