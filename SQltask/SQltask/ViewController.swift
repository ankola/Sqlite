//
//  ViewController.swift
//  SQltask
//
//  Created by agile on 5/14/18.
//  Copyright © 2018 agile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {  
    
    @IBOutlet var studTable:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SQLdatabase.sharedinstance.createTable()
        SQLdatabase.sharedinstance.fetchdata()
    }
    
    @IBAction func btnAdd(sender: UIBarButtonItem){
        let objstr = storyboard?.instantiateViewController(withIdentifier: "StudentDettails") as! StudentDettails
        self.navigationController?.pushViewController(objstr, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SQLdatabase.sharedinstance.fetchdata()
        return SQLdatabase.sharedinstance.StudArrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        SQLdatabase.sharedinstance.fetchdata()
        let data : Array = SQLdatabase.sharedinstance.StudArrData
        
        cell.lblStudentName.text = data[indexPath.row]["namestr"] as! String
        
        if ("\(data[indexPath.row]["perstr"]!)") != nil {
            cell.lblStudentPer.text = ("\(data[indexPath.row]["perstr"]!)")
        }
        else
        {
            cell.lblStudentPer.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studvc : StudentDettails =                      storyboard?.instantiateViewController(withIdentifier: "StudentDettails") as! StudentDettails
        SQLdatabase.sharedinstance.fetchdata()
        let data =  SQLdatabase.sharedinstance.StudArrData[indexPath.row]
        var v = data["namestr"]!
        studvc.checkSaveEdit = true
        studvc.indexget = data["idstr"] as! Int
        var a:Any?
        if data["totalstr"] != nil {
            a = data["totalstr"]!
        }
        studvc.dictdataparse = ["name":data["namestr"]!,"stand":data["standstr"]!,"grade":data["gradestr"]!,"college":data["collegestr"]!,"num":data["numstr"]!,"total":a!]
        
        self.navigationController?.pushViewController(studvc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            SQLdatabase.sharedinstance.fetchdata()
            let arr = SQLdatabase.sharedinstance.StudArrData[indexPath.row]
            let getid = arr["idstr"]!
            
            SQLdatabase.sharedinstance.DeleteData(ind: getid)
            self.studTable.reloadData()
            SQLdatabase.sharedinstance.fetchdata()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.studTable.reloadData()
    }
}

