//
//  ReviewsTableViewController.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class ReviewsTableViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,ReviewDataManagerDelegate {

   //MARK: Properties
  @IBOutlet weak var tableView: UITableView!
//  var reviews:[Review]?
  var selectedStoreIndex = 146
  var selectedAppIndex = 0
  var appIDArray = ["1128598578","920659520"]
  var appArray = ["Night club strobe light","Scan & translate"]
   let reviewsDataManager = ReviewDataManager()



  override func viewDidLoad() {
    super.viewDidLoad()
    reviewsDataManager.delegate = self

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return reviewsDataManager.availableCountryCode
  }

      

  func numberOfSections(in tableView: UITableView) -> Int {

    print("Number of section: \(reviewsDataManager.availableCountryCode.count)")
    return reviewsDataManager.availableCountryCode.count

  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    print("Request for section: \(section)")
    let a =  reviewsDataManager.getCountryNameWith(code: reviewsDataManager.availableCountryCode[section])
    
    return a
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if let reviews = reviewsDataManager.reviewData[reviewsDataManager.availableCountryCode[section]]{
      return reviews.count
    }
    else{
      return 1
    }

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier : String = "CellIdentifier"

    let cell = self.tableView .dequeueReusableCell(withIdentifier: cellIdentifier) as! ReviewTableViewCell

    if let review = reviewsDataManager.getReviewsFrom(countryCode: reviewsDataManager.availableCountryCode[indexPath.section])[indexPath.row]{
      cell.setCellContent(review: review)
    }
    else{
      cell.setCellContent(review: Review())
    }



    return cell

  }

  //Auto resize cell height
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
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
      ActionSheetMultipleStringPicker.show(withTitle: "Switch Store", rows: [
        self.reviewsDataManager.availableCountryCode
        ], initialSelection: [self.selectedStoreIndex], doneBlock: {
          picker, indexes, values in

          self.selectedStoreIndex = indexes?[0] as! Int
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)


    })

    alertAction.addAction(switchStore)

    let switchApp: UIAlertAction = UIAlertAction(title: "Switch app", style: .default, handler: { (action) in
      //      alertAction.dismiss(animated: true, completion: nil)
      ActionSheetMultipleStringPicker.show(withTitle: "Switch Store", rows: [
        self.appArray
        ], initialSelection: [self.selectedAppIndex], doneBlock: {
          picker, indexes, values in

          self.selectedAppIndex = indexes?[0] as! Int

        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)


    })

    alertAction.addAction(switchApp)

    self.present(alertAction, animated: true, completion: nil)

  }


  // MARK: Delegate

  func dataUpdated(forCountryCode: String, newData: [Review?]?){
    OperationQueue.main.addOperation {
      print("Updated \(forCountryCode)")
       print("NEW: \(self.reviewsDataManager.availableCountryCode.count)")
       self.tableView.reloadData()
    }

  }
}
