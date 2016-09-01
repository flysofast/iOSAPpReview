//
//  ViewController.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 8/31/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func btTapped(_ sender: AnyObject) {
    print(ReviewRetriver.getReviewsFrom(AppID: "1128598578", completion: { (reviews) in
      print(reviews?.first)
    }))

  }
  
}

