//
//  ReviewTableViewCell.swift
//  AppReviewReport
//
//  Created by Le Hai Nam on 9/1/16.
//  Copyright © 2016 FlySoFast. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

  @IBOutlet weak var lbContent: UILabel!
  @IBOutlet weak var lbTitle: UILabel!
  @IBOutlet weak var lbAuthor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  public func setCellContent(review: Review){

    let rate :String = getStarString(star: review.ratingStars)

    self.lbTitle.text = "\(rate) - \(review.title)"
    self.lbAuthor.text = "\(review.author) - \(review.version)"
    self.lbContent.text = review.content
  }

  public func getStarString(star: Int) -> String{
    var result: String = ""
    for _ in 0..<star{
      result += "☆"
    }

    for _ in 0..<5-star{

       result += "★"
    }

    return result
  }

}
