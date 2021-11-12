//
//  DetailsVC.swift
//  SampleProject
//
//  Created by Nitin Chauhan on 12/11/21.
//

import UIKit

class DetailsVC: UIViewController {
    var dict:[String:Any] = [:]
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = dict["name"] as? String
        phoneLbl.text = dict["phone"] as? String
        websiteLbl.text = dict["website"] as? String
        emailLbl.text = dict["email"] as? String
        
        if let dic:[String:Any] = dict["address"] as? [String : Any] {
            addressLbl.text = "\(dic["street"] ?? "")\n\(dic["city"] ?? "")\n\(dic["zipcode"] ?? "")"
            addressLbl.numberOfLines = 0

        }
        
        if let dic:[String:Any] = dict["company"] as? [String : Any] {
            companyLbl.text = "\(dic["name"] ?? ""))"

        }
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
