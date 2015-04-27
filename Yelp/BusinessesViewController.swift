//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {

    @IBOutlet weak var businessesTableView: UITableView!

    var searchBar = UISearchBar()

    var businesses: [Business]!
    var categories = ["restaurants"]
    var deals = true
    var searchText = "Restaurants"
    var sort = YelpSortMode.BestMatched

    let sortMap = [
        0: YelpSortMode.BestMatched,
        1: YelpSortMode.Distance,
        2: YelpSortMode.HighestRated
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

//        Business.searchWithTerm("Thai", completion: { (businesses: [Business]!, error: NSError!) -> Void in
//            self.businesses = businesses
//            
//            for business in businesses {
//                println(business.name!)
//                println(business.address!)
//            }
//        })

        Business.searchWithTerm(self.searchText, sort: self.sort, categories: self.categories, deals: self.deals) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
        }

        businessesTableView.dataSource = self
        businessesTableView.delegate = self
        businessesTableView.rowHeight = UITableViewAutomaticDimension
        businessesTableView.estimatedRowHeight = 140
        searchBar.delegate = self

        self.navigationItem.titleView = searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        Business.searchWithTerm(self.searchText, sort: self.sort, categories: self.categories, deals: self.deals) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businesses {
            return businesses.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessTableViewCell

        let business = businesses![indexPath.row]
        cell.businessImageView.setImageWithURL(business.imageURL)
        cell.businessNameLabel.text = business.name
        cell.businessDistanceLabel.text = business.distance
        cell.businessRatingImageView.setImageWithURL(business.ratingImageURL)
        cell.businessReviewCountLabel.text = "\(business.reviewCount!) Reviews"
        cell.businessAddressLabel.text = business.address
        cell.businessCategoriesLabel.text = business.categories
        return cell
    }

    func filtersViewController(filtersViewController: FiltersViewController, filtersDidChange filtersDictionary: [String: AnyObject]) {
        self.categories = filtersDictionary["categories"] as! [String]
        self.deals = filtersDictionary["deals"] as! Bool
        self.sort = self.sortMap[filtersDictionary["sort"] as! Int]!
        Business.searchWithTerm(self.searchText, sort: self.sort, categories: self.categories, deals: self.deals) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.businessesTableView.reloadData()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        if sender!.title == "Filter" {
            let filtersViewController = navigationController.topViewController as! FiltersViewController
            filtersViewController.delegate = self
        } else {
            let mapViewController = navigationController.topViewController as! MapViewController
            mapViewController.businesses = self.businesses
        }
    }
}
