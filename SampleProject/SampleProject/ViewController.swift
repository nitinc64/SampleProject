//
//  ViewController.swift
//  SampleProject
//
//  Created by Nitin Chauhan on 12/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var array:[Any] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        if (UserDefaults.standard.object(forKey: "data") != nil) {
            array = UserDefaults.standard.object(forKey: "data") as! [Any]
        } else {
            array = []
        }
        // Do any additional setup after loading the view.
        httpRequest()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dict:[String:Any] = array[indexPath.row] as! [String : Any]
        let nameLbl: UILabel = cell.viewWithTag(1) as! UILabel
        nameLbl.text = dict["name"] as! String
        let phoneLbl: UILabel = cell.viewWithTag(2) as! UILabel
        phoneLbl.text = dict["phone"] as! String

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.dict = array[indexPath.row] as! [String : Any]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func httpRequest() {

        //create the url with NSURL
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        let request = URLRequest(url: url)

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                    print(json)
                    self.array = json
                    UserDefaults.standard.setValue(json, forKey: "data")
                   
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }

}

