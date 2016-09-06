//
//  ReviewsTableViewController.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit

class ReviewsTableViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

   //MARK: Properties
  @IBOutlet weak var tableView: UITableView!
  var reviews:[Review]?
  let countryCodeArray:[String] = ["ALL","AE","AG","AI","AL","AM","AO","AR","AT","AU","AZ","BB","BE","BF","BG","BH","BJ","BM","BN","BO","BR","BS","BT","BW","BY","BZ","CA","CG","CH","CL","CN","CO","CR","CV","CY","CZ","DE","DK","DM","DO","DZ","EC","EE","EG","ES","FI","FJ","FM","FR","GB","GD","GH","GM","GR","GT","GW","GY","HK","HN","HR","HU","ID","IE","IL","IN","IS","IT","JM","JO","JP","KE","KG","KH","KN","KR","KW","KY","KZ","LA","LB","LC","LK","LR","LT","LU","LV","MD","MG","MK","ML","MN","MO","MR","MS","MT","MU","MW","MX","MY","MZ","NA","NE","NG","NI","NL","NO","NP","NZ","OM","PA","PE","PG","PH","PK","PL","PT","PW","PY","QA","RO","RU","SA","SB","SC","SE","SG","SI","SK","SL","SN","SR","ST","SV","SZ","TC","TD","TH","TJ","TM","TN","TR","TT","TW","TZ","UA","UG","US","UY","UZ","VC","VE","VG","VN","YE","ZA","ZW"]

  let countryArray:[String] = ["All countries","United Arab Emirates","Antigua and Barbuda","Anguilla","Albania","Armenia","Angola","Argentina","Austria","Australia","Azerbaijan","Barbados","Belgium","Burkina Faso","Bulgaria","Bahrain","Benin","Bermuda","Brunei","Bolivia","Brazil","Bahamas","Bhutan","Botswana","Belarus","Belize","Canada","Republic Of Congo","Switzerland","Chile","China","Colombia","Costa Rica","Cape Verde","Cyprus","Czech Republic","Germany","Denmark","Dominica","Dominican Republic","Algeria","Ecuador","Estonia","Egypt","Spain","Finland","Fiji","Federated States Of Micronesia","France","United Kingdom","Grenada","Ghana","Gambia","Greece","Guatemala","Guinea-Bissau","Guyana","Hong Kong","Honduras","Croatia","Hungary","Indonesia","Ireland","Israel","India","Iceland","Italy","Jamaica","Jordan","Japan","Kenya","Kyrgyzstan","Cambodia","St. Kitts and Nevis","Republic Of Korea","Kuwait","Cayman Islands","Kazakstan","Lao People’s Democratic Republic","Lebanon","St. Lucia","Sri Lanka","Liberia","Lithuania","Luxembourg","Latvia","Republic Of Moldova","Madagascar","Macedonia","Mali","Mongolia","Macau","Mauritania","Montserrat","Malta","Mauritius","Malawi","Mexico","Malaysia","Mozambique","Namibia","Niger","Nigeria","Nicaragua","Netherlands","Norway","Nepal","New Zealand","Oman","Panama","Peru","Papua New Guinea","Philippines","Pakistan","Poland","Portugal","Palau","Paraguay","Qatar","Romania","Russia","Saudi Arabia","Solomon Islands","Seychelles","Sweden","Singapore","Slovenia","Slovakia","Sierra Leone","Senegal","Suriname","Sao Tome and Principe","El Salvador","Swaziland","Turks and Caicos","Chad","Thailand","Tajikistan","Turkmenistan","Tunisia","Turkey","Trinidad and Tobago","Taiwan","Tanzania","Ukraine","Uganda","United States","Uruguay","Uzbekistan","St. Vincent and The Grenadines","Venezuela","British Virgin Islands","Vietnam","Yemen","South Africa","Zimbabwe"]


  @IBOutlet weak var countryPicker: UIPickerView!

  override func viewDidLoad() {
    super.viewDidLoad()

    loadRateAndReviews(AppID: "1128598578", Country: "us")


    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return countryCodeArray
  }
  func loadRateAndReviews(AppID: String, Country:String)  {
    ReviewRetriver.getReviewsFrom(AppID: AppID, Country: Country) { (list) in
      self.reviews=list

      OperationQueue.main.addOperation({
        self.tableView.reloadData()
      })

    }
  }
      

  func numberOfSections(in tableView: UITableView) -> Int {

    var numOfSections: Int = 0
    if self.reviews != nil && self.reviews!.count > 0
    {

      numOfSections                = countryCodeArray.count
      self.tableView.backgroundView = nil
      self.tableView.separatorStyle = .singleLine
    }
    else
    {
      let noDataLabel: UILabel     = UILabel(frame: CGRect(x:0, y:0, width:self.tableView.bounds.size.width, height:self.tableView.bounds.size.height))
      noDataLabel.text             = "No data available"
      noDataLabel.textColor        = UIColor.black
      noDataLabel.textAlignment    = .center
      self.tableView.backgroundView = noDataLabel
      self.tableView.separatorStyle = .none
    }
    return numOfSections
    
    
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return countryCodeArray[section]
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if let reviews = self.reviews {
      if (section != 0) {
        return 0
      }

      return reviews.count
    }
    else{
      return 0
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier : String = "CellIdentifier"

    let cell = self.tableView .dequeueReusableCell(withIdentifier: cellIdentifier) as! ReviewTableViewCell

    if let review = reviews?[indexPath.row]{
      cell.setCellContent(review: review)
    }

    return cell

  }

  //MARK: PickerView
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    loadRateAndReviews(AppID: "1128598578", Country: countryCodeArray[row])
    pickerView.isHidden=true

  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return countryArray[row]
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return countryArray.count
  }

  public func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  //MARK: Action

  @IBAction func btActionTapped(_ sender: AnyObject) {
    let alertAction = UIAlertController.init(title: "View settings", message: "Options", preferredStyle: .actionSheet)


    let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
      alertAction.dismiss(animated: true, completion: nil)
    })
    
    alertAction.addAction(cancelAction)

    let switchStore: UIAlertAction = UIAlertAction(title: "Switch store", style: .default, handler: { (action) in
//      alertAction.dismiss(animated: true, completion: nil)
      self.countryPicker.isHidden = false

    })

    alertAction.addAction(switchStore)

    self.present(alertAction, animated: true, completion: nil)
    
  }
}



