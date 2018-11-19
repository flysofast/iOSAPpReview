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
  var appIDArray = ["1128598578","920659520"]
  var appArray = ["Night club strobe light","Scan & translate"]
   let reviewsDataManager = ReviewDataManager()
  var refreshControl = UIRefreshControl()

  override func viewDidLoad() {
    super.viewDidLoad()
    reviewsDataManager.delegate = self

    self.tableView.sectionIndexBackgroundColor = UIColor.init(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0.5)
    self.tableView.addSubview(refreshControl)

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Table view data source

  func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    return reviewsDataManager.getAvailableCountryCodes()
  }

      

  func numberOfSections(in tableView: UITableView) -> Int {

       return reviewsDataManager.getAvailableCountryCodes().count

  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return reviewsDataManager.getCountryNameWith(index: section)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if let reviews = reviewsDataManager.reviewData[reviewsDataManager.getAvailableCountryWith(index: section)]{
      return reviews.count
    }
    else{
      return 1
    }

  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier : String = "CellIdentifier"

    let cell = self.tableView .dequeueReusableCell(withIdentifier: cellIdentifier) as! ReviewTableViewCell

     let review = reviewsDataManager.getReviewsFor(countryCode: reviewsDataManager.getAvailableCountryWith(index: indexPath.section), index: indexPath.row)
      cell.setCellContent(review: review)




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


    let switchApp: UIAlertAction = UIAlertAction(title: "Switch app", style: .default, handler: { (action) in
      //      alertAction.dismiss(animated: true, completion: nil)
      ActionSheetMultipleStringPicker.show(withTitle: "Switch app", rows: [
        self.appArray
        ], initialSelection: [self.reviewsDataManager.selectedAppIndex], doneBlock: {
          picker, indexes, values in

          self.reviewsDataManager.selectedAppIndex = indexes?[0] as! Int
          self.reviewsDataManager.refreshData()

        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)


    })

    alertAction.addAction(switchApp)

    self.present(alertAction, animated: true, completion: nil)

  }

  // MARK: Delegate

  func dataUpdated(forCountryCode: String, newData: [Review?]?){
    OperationQueue.main.addOperation {
      print("Updated \(forCountryCode)")
      self.tableView.reloadData()
//      self.tableView.reloadRows(at: self.tableView.indexPathsForVisibleRows!, with: .fade)
    }

  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if (refreshControl.isRefreshing){
      reviewsDataManager.refreshData()
      self.refreshControl.endRefreshing()
    }
  }
}
