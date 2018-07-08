
import UIKit
protocol dataparse {
    func data(fname:String,lname:String,number:Double,email:String,get:Int, check:Bool)
}

class SecondViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, cellDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    var delegate:dataparse? = nil
    var getid:Int?
    var checkAddorUpdate = false
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblView.delegate = self
        tblView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SqlDatabase.sharedInstance.fetchdata()
        return SqlDatabase.sharedInstance.StudArrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = (tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell)!
        
        SqlDatabase.sharedInstance.fetchdata()
        var data = SqlDatabase.sharedInstance.StudArrData
        
         cell.lblFName.text = data[indexPath.row]["Fname"] as! String
         cell.lblLname.text = data[indexPath.row]["Lname"] as! String
         cell.lblEmail.text = data[indexPath.row]["Email"] as! String
         cell.lblNumber.text = "\(data[indexPath.row]["Number"] as! Double)"
        
        cell.delegate = self
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var getdata = SqlDatabase.sharedInstance.StudArrData[indexPath.row]
        
        delegate?.data(fname: getdata["Fname"] as! String, lname: getdata["Lname"] as! String, number: getdata["Number"] as! Double, email: getdata["Email"] as! String,get: indexPath.row, check: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didTapDelete(tag: Int) {
        print("tag",tag)
        
        SqlDatabase.sharedInstance.fetchdata()
        var get = SqlDatabase.sharedInstance.StudArrData[tag]["Id"]
        SqlDatabase.sharedInstance.DeleteData(ind: get!)
        self.tblView.reloadData()
    }
    
    
}
