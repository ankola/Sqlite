//
//  StudentDettails.swift
//  SQltask
//
//  Created by agile on 5/14/18.
//  Copyright © 2018 agile. All rights reserved.
//

import UIKit
import SQLite3

class StudentDettails: UIViewController {
    
    var dictdataparse = [String:Any]()
    var checkSaveEdit:Bool?
    var indexget:Int?
    
    @IBOutlet var txtStandard: UITextField!
    @IBOutlet var txtName:UITextField!
    @IBOutlet var txtNumber:UITextField!
    @IBOutlet var txtPercen: UITextField!
    @IBOutlet var txtCollege: UITextField!
    @IBOutlet var lblTotalMarks: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checkSaveEdit == true {
        txtName.placeholder = dictdataparse["name"] as! String
        txtNumber.placeholder = ("\(dictdataparse["num"]!)")
        txtPercen.placeholder = dictdataparse["grade"] as! String
        txtStandard.placeholder = ("\(dictdataparse["stand"]!)")
        txtCollege.placeholder = dictdataparse["college"] as! String
        lblTotalMarks.text = "\(dictdataparse["total"]!)"
        }

    }


    @IBAction func btnAddMarks(_ sender: UIButton) {
        let objstory = storyboard?.instantiateViewController(withIdentifier: "Subjects") as! Subjects
        
        SQLdatabase.sharedinstance.fetchdata()
        objstory.getid = indexget
        objstory.checkSaveOrUpdate = checkSaveEdit
        
        if checkSaveEdit != true {
            // Save Student Dettails

            let getarr = SQLdatabase.sharedinstance.StudArrData.last
            objstory.getid = getarr!["idstr"] as! Int
            
            var dict:[String:Any] = ["name":txtName.text,"standard":txtStandard.text,"college":txtCollege.text,"grade":txtPercen.text,"number":txtNumber.text]
            
            SQLdatabase.sharedinstance.savedata(object: dict as! [String : String])
            SQLdatabase.sharedinstance.fetchdata()
        }
        
        else{
        // Update Student Dettails
            var dict1:[String:Any] = ["name":txtName.text,"standard":txtStandard.text,"college":txtCollege.text,"grade":txtPercen.text,"number":txtNumber.text]
            SQLdatabase.sharedinstance.UpdateStudentDettails(object: dict1 as! [String : String], ind: indexget!)
            }
            
        // Save Student Dettails
       // else{
//            var dict:[String:Any] = ["name":txtName.text,"standard":txtStandard.text,"college":txtCollege.text,"grade":txtPercen.text,"number":txtNumber.text]
//
//            SQLdatabase.sharedinstance.savedata(object: dict as! [String : String])
//            SQLdatabase.sharedinstance.fetchdata()
       // }
        
        self.navigationController?.pushViewController(objstory, animated: true)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
//        if checkSaveEdit == true {
//           var dict1:[String:Any] = ["name":txtName.text,"standard":txtStandard.text,"college":txtCollege.text,"grade":txtPercen.text,"number":txtNumber.text]
//            SQLdatabase.sharedinstance.UpdateStudentDettails(object: dict1 as! [String : String], ind: indexget!)
//        }else{
//
//        var dict:[String:Any] = ["name":txtName.text,"standard":txtStandard.text,"college":txtCollege.text,"grade":txtPercen.text,"number":txtNumber.text]
//
//        SQLdatabase.sharedinstance.savedata(object: dict as! [String : String])
//            SQLdatabase.sharedinstance.fetchdata()
//        }
    }
   
}
