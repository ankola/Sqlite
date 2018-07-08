
import Foundation
import SQLite3

class SqlDatabase {
    
    var db:OpaquePointer?
    var stmt:OpaquePointer? = nil
    
    var StudArrData:Array = [["Id":Int.self,"Fname":String.self,"Lname":String.self,"Email":String.self,"Number":Double.self]]
    
    static var sharedInstance = SqlDatabase()
    
    func createTable() {
        let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("students.sqlite")
        print("path is",url)
        
        if sqlite3_open(url.path, &db) != SQLITE_OK {
            print("error in opening Database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Students(id INTEGER PRIMARY KEY AUTOINCREMENT, fname TEXT, lname TEXT, number DOUBLE, email TEXT)", nil, nil, nil) != SQLITE_OK {
            print("error in creating table")
        }
    }
    
        func savedata(object:[String:String]) {
            
            var strfname:NSString = object["fname"]! as NSString
            var strlname:NSString = object["lname"]! as NSString
            var stremail:NSString = object["email"]! as NSString
            var strnumber:Double = (object["number"]as! NSString).doubleValue
            
            let querystr = "INSERT INTO Students (fname , lname , number , email) VALUES (?, ?, ?, ?)"
            
            if sqlite3_prepare(db, querystr, -1, &stmt, nil) != SQLITE_OK{
                print("error in preparing data")
            }
            
            sqlite3_bind_double(stmt, 3, strnumber)
            sqlite3_bind_text(stmt, 1, strfname.utf8String, -1, nil)
            sqlite3_bind_text(stmt, 2, strlname.utf8String, -1, nil)
            
            sqlite3_bind_text(stmt, 4, stremail.utf8String, -1 , nil)
            
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("insert data saved")
                
            }
    }
    
    func fetchdata() {
        self.StudArrData.removeAll()
        let fetchstr = "SELECT * FROM Students"
        
        if sqlite3_prepare_v2(db, fetchstr, -1, &stmt, nil) != SQLITE_OK {
            print("error in fetch prepare")
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let fname = String(cString: sqlite3_column_text(stmt, 1)!)
            let lname = String(cString: sqlite3_column_text(stmt, 2))
            let number = sqlite3_column_double(stmt, 3)
            let email = String(cString: sqlite3_column_text(stmt, 4))
            
            let dict = ["Id":id,"Fname":fname,"Lname":lname,"Email":email,"Number":number] as [String : Any]
           
            self.StudArrData.append(dict as! Dictionary)
        }
    }
    
    func UpdateStudentDettails(object:[String:String], ind:Any) {
        
        let fname = object["fname"]!
        let lname = object["lname"]!
        let email = object["email"]!
        let number = object["number"]!
        
        let updatestr = "UPDATE Students SET (fname, lname, email, number) = ('\(fname)','\(lname)','\(email)','\(number)') WHERE id = \(ind)"
        
        if sqlite3_prepare_v2(db, updatestr, -1, &stmt, nil) != nil {
            if sqlite3_step(stmt) != SQLITE_DONE{
                print("error in update data")
            }
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            print("error in finlize")
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
    
}
