//
//  MapViewController.swift
//  Yelp
//
//  Created by Ho-Hsiang Wu on 4/26/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import MapKit
import UIKit


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var listButton: UIBarButtonItem!

    var businesses: [Business]!

    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2D(
            latitude: 37.785771,
            longitude: -122.406165
        )

        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)

        for business in businesses {
            let address = business.address
            if let address = address {
                var geocoder = CLGeocoder()
                geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
                    if let placemark = placemarks?[0] as? CLPlacemark {
                        if let coordinate = placemark.location?.coordinate {
                            var annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            annotation.title = business.name
                            annotation.subtitle = business.address
                            self.mapView.addAnnotation(annotation)
                        }
                     }
                })
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onListButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
