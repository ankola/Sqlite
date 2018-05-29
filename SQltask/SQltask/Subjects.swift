//
//  Subjects.swift
//  SQltask
//
//  Created by agile on 5/14/18.
//  Copyright © 2018 agile. All rights reserved.
//

import UIKit

class Subjects: UIViewController {
    
    var  getid:Int?
    var checkSaveOrUpdate:Bool?
    
    @IBOutlet var txtCLan: UITextField!
    @IBOutlet var txtPhp: UITextField!
    @IBOutlet var txtDotNet: UITextField!
    @IBOutlet var txtJava: UITextField!
    @IBOutlet var txtSeo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if checkSaveOrUpdate == true{
            SQLdatabase.sharedinstance.fetchdata()
            let getarr = SQLdatabase.sharedinstance.StudArrData[getid!]
            txtCLan.placeholder = getarr["clanstr"] as! String
            txtPhp.placeholder = getarr["phpstr"] as! String
            txtDotNet.placeholder = getarr["dotnetstr"] as! String
            txtJava.placeholder = getarr["javastr"] as! String
            txtSeo.placeholder = getarr["seostr"] as! String
        }
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        var dict = ["clan":txtCLan.text,"php":txtPhp.text,"dotnet":txtDotNet.text,"java":txtJava.text,"seo":txtSeo.text]
        
        if (txtCLan.text! as NSString).intValue < 1 || (txtCLan.text! as NSString).intValue > 100 {
            self.alert(Title: "Enter Clan Mark")
        }
            
        else if (txtPhp.text! as NSString).intValue < 1 || (txtPhp.text! as NSString).intValue > 100 {
            self.alert(Title: "Enter PHP Mark")
        }
            
        else if (txtDotNet.text! as NSString).intValue < 1 || (txtDotNet.text! as NSString).intValue > 100 {
            self.alert(Title: "Enter DotNet Mark")
        }
            
        else if (txtJava.text! as NSString).intValue < 1 || (txtJava.text! as NSString).intValue > 100 {
            self.alert(Title: "Enter JaVA Mark")
        }
            
        else if (txtSeo.text! as NSString).intValue < 1 || (txtSeo.text! as NSString).intValue > 100 {
            self.alert(Title: "Enter Seo Mark")
        }
        SQLdatabase.sharedinstance.UpadateMarks(object: dict as! [String:String], ind1: getid!)
        
    }
    
    func alert(Title:String) {
        let alert = UIAlertView()
        alert.title = Title
        alert.addButton(withTitle: "OK")
        alert.show()
    }
}
