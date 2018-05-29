//
//  SqliteDatabase.swift
//  SQltask
//
//  Created by agile on 5/15/18.
//  Copyright © 2018 agile. All rights reserved.
//

import Foundation
import SQLite3

class SQLdatabase {
    
    var db:OpaquePointer?
    var stmt:OpaquePointer? = nil
    var StudArrData:Array = [["idstr":Int.self,"namestr":Any.self,"standstr":Any.self,"gradestr":Any.self,"collegestr":Any.self,"numstr":Any.self,"clanstr":Any.self,"phpstr":Any.self,"dotnetstr":Any.self,"javastr":Any.self,"seostr":Any.self,"totalstr":Any.self,"perstr":Any.self]]

    static var sharedinstance = SQLdatabase()
    
    func createTable() {
        let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("students.sqlite")
        print(url)
        
        if sqlite3_open(url.path, &db) != SQLITE_OK {
            print("error in opening Database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, standard INTEGER, grade TEXT, college TEXT, number DOUBLE, clan INTEGER, php INTEGER, dotnet INTEGER, java INTEGER, seo INTEGER)", nil, nil, nil) != SQLITE_OK {
            print("error in creating table")
           
        }
    }
    
    func savedata(object:[String:String]) {
        
        var strname:NSString = object["name"]! as NSString
        var strstan = object["standard"]
        var strgrade:NSString = object["grade"] as! NSString
        var strcol:NSString = object["college"] as! NSString
        var strnum:Double = (object["number"]as! NSString).doubleValue
        
        let querystr = "INSERT INTO Students (name, standard, grade, college, number) VALUES (?, ?, ?, ?, ?)"
        
        if sqlite3_prepare(db, querystr, -1, &stmt, nil) != SQLITE_OK{
            print("error in preparing data")
        }
        
        sqlite3_bind_double(stmt, 5, strnum)
        sqlite3_bind_text(stmt, 1, strname.utf8String, -1, nil)
        sqlite3_bind_int(stmt, 2, (strstan! as NSString).intValue)
        sqlite3_bind_text(stmt, 3, strgrade.utf8String, -1 , nil)
        sqlite3_bind_text(stmt, 4, strcol.utf8String, -1, nil)
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("insert data saved")
            
        }
        fetchdata()
    }
    
    func fetchdata() {
        self.StudArrData.removeAll()
        let fetchstr = "SELECT * FROM Students"
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &stmt, nil) != SQLITE_OK {
            print("error in fetch prepare")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1)!)
            let stand = sqlite3_column_int(stmt, 2)
            let grade = String(cString: sqlite3_column_text(stmt, 3))
            let college = String(cString: sqlite3_column_text(stmt, 4))
            let num = sqlite3_column_double(stmt, 5)
            let clan = sqlite3_column_double(stmt, 6)
            let php = sqlite3_column_double(stmt, 7)
            let dotnet = sqlite3_column_double(stmt, 8)
            let java = sqlite3_column_double(stmt, 9)
            let seo = sqlite3_column_double(stmt, 10)
            let total = clan+php+dotnet+java+seo
            let per = total/5
         
            let dict = ["idstr":id,"namestr":name,"standstr":stand,"gradestr":grade,"collegestr":college,"numstr":num,"clanstr":clan,"phpstr":php,"dotnetstr":dotnet,"javastr":java,"seostr":seo,"totalstr":total,"perstr":per] as [String : Any]
            self.StudArrData.append(dict as Dictionary)
        }
    }
    
    func DeleteData(ind: Any) {
        print(ind)
        let deltestr = "DELETE FROM Students WHERE id = \(ind)"
        
        if sqlite3_prepare_v2(db, deltestr, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("successfully deleted row")
            }else{
                print("could not delete row")
            }
        } else{
            print("Delete statement could not be prepared")
        }
        sqlite3_finalize(stmt)
    }
    
    func UpdateStudentDettails(object:[String:String], ind:Any) {
        
        let name = object["name"]!
        let stand = object["standard"]!
        let grade = object["grade"]!
        let college = object["college"]!
        let num = object["number"]!
        
        let arrname = ["name","stand","grade","college","num"]
        
        let updatestr = "UPDATE Students SET (name, standard, grade, college, number) = ('\(name)','\(stand)','\(grade)','\(college)','\(num)') WHERE id = \(ind)"
        
        if sqlite3_prepare_v2(db, updatestr, -1, &stmt, nil) != nil {
            if sqlite3_step(stmt) != SQLITE_DONE{
                print("error in update data")
            }
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            print("error in finlize")
        }
    }
    
    func UpadateMarks(object:[String:String], ind1:Any) {
        var strclan = object["clan"]!
        var strphp = object["php"]!
        var strdotnet = object["dotnet"]!
        var strjava = object["java"]!
        var strseo = object["seo"]!
        
        let updatestr = "UPDATE Students SET (clan, php, dotnet, java, seo) = ('\(strclan)','\(strphp)','\(strdotnet)','\(strjava)','\(strseo)') WHERE id = \(ind1)"
        
        if sqlite3_prepare_v2(db, updatestr, -1, &stmt, nil) != nil {
            if sqlite3_step(stmt) != SQLITE_DONE{
                print("error in update data")
            }
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK {
            print("error in finlize")
        }
        
    }
    
}
