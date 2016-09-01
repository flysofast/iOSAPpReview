//
//  ReviewsTableViewController.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit

class ReviewsTableViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {


  //MARK: Properties
  @IBOutlet weak var tableView: UITableView!
  var reviews:[Review]?

  override func viewDidLoad() {
    super.viewDidLoad()


    ReviewRetriver.getReviewsFrom(AppID: "1128598578") { (list) in
      self.reviews=list

      OperationQueue.main.addOperation({
        self.tableView.reloadData()
      })
      
    }

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

   func numberOfSections(in tableView: UITableView) -> Int {

    return 1


  }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    if let reviews = self.reviews {
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


}
