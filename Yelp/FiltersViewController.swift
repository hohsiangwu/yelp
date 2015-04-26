//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Ho-Hsiang Wu on 4/25/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate: class {
    optional func filtersViewController(filtersViewController: FiltersViewController, filtersDidChange filtersDictionary: [String: AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CategoryTableViewCellDelegate {

    weak var delegate: FiltersViewControllerDelegate?

    @IBOutlet weak var cancelBarButton: UIButton!
    @IBOutlet weak var searchBarButton: UIButton!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var sortSegment: UISegmentedControl!
    @IBOutlet weak var dealSwitch: UISwitch!

    var categories: [[String: String]]!

    private var categoriesSwitchDictionary = [Int: Bool]()
    private var filtersDictionary = [String: AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        categories = yelpCategories()
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryTableViewCell

        let category = categories[indexPath.row]
        cell.categoryLabel.text = category["name"]
        cell.delegate = self

        if let value = categoriesSwitchDictionary[indexPath.row] {
            cell.categorySwitch.on = value
        } else {
            cell.categorySwitch.on = false
        }
        return cell
    }

    func categoryCell(categoryCell: CategoryTableViewCell, didChangeSwitchValue value: Bool) {
        let indexPath = categoriesTableView.indexPathForCell(categoryCell)
        categoriesSwitchDictionary[indexPath!.row] = value
    }

    func yelpCategories() -> [[String: String]] {
        return [
            ["name": "Abruzzese", "code": "abruzzese"],
            ["name": "Afghan", "code": "afghani"],
            ["name": "African", "code": "african"],
            ["name": "Alentejo", "code": "alentejo"],
            ["name": "Algarve", "code": "algarve"],
            ["name": "Alsatian", "code": "alsatian"],
            ["name": "Altoatesine", "code": "altoatesine"],
            ["name": "American (New)", "code": "newamerican"],
            ["name": "American (Traditional)", "code": "tradamerican"],
            ["name": "Apulian", "code": "apulian"],
            ["name": "Arab Pizza", "code": "arabpizza"],
            ["name": "Arabian", "code": "arabian"],
            ["name": "Argentine", "code": "argentine"],
            ["name": "Armenian", "code": "armenian"],
            ["name": "Arroceria / Paella", "code": "arroceria_paella"],
            ["name": "Asian Fusion", "code": "asianfusion"],
            ["name": "Asturian", "code": "asturian"],
            ["name": "Australian", "code": "australian"],
            ["name": "Austrian", "code": "austrian"],
            ["name": "Auvergnat", "code": "auvergnat"],
            ["name": "Azores", "code": "azores"],
            ["name": "Baden", "code": "baden"],
            ["name": "Baguettes", "code": "baguettes"],
            ["name": "Bangladeshi", "code": "bangladeshi"],
            ["name": "Barbeque", "code": "bbq"],
            ["name": "Basque", "code": "basque"],
            ["name": "Bavarian", "code": "bavarian"],
            ["name": "Beer Garden", "code": "beergarden"],
            ["name": "Beer Hall", "code": "beerhall"],
            ["name": "Beira", "code": "beira"],
            ["name": "Beisl", "code": "beisl"],
            ["name": "Belgian", "code": "belgian"],
            ["name": "Berrichon", "code": "berrichon"],
            ["name": "Bistros", "code": "bistros"],
            ["name": "Black Sea", "code": "blacksea"],
            ["name": "Blowfish", "code": "blowfish"],
            ["name": "Bourguignon", "code": "bourguignon"],
            ["name": "Brasseries", "code": "brasseries"],
            ["name": "Brazilian", "code": "brazilian"],
            ["name": "Brazilian Empanadas", "code": "brazilianempanadas"],
            ["name": "Breakfast & Brunch", "code": "breakfast_brunch"],
            ["name": "British", "code": "british"],
            ["name": "Buffets", "code": "buffets"],
            ["name": "Bulgarian", "code": "bulgarian"],
            ["name": "Burgers", "code": "burgers"],
            ["name": "Burmese", "code": "burmese"],
            ["name": "Cafes", "code": "cafes"],
            ["name": "Cafeteria", "code": "cafeteria"],
            ["name": "Cajun/Creole", "code": "cajun"],
            ["name": "Calabrian", "code": "calabrian"],
            ["name": "Cambodian", "code": "cambodian"],
            ["name": "Canadian (New)", "code": "newcanadian"],
            ["name": "Canteen", "code": "canteen"],
            ["name": "Cantonese", "code": "cantonese"],
            ["name": "Caribbean", "code": "caribbean"],
            ["name": "Catalan", "code": "catalan"],
            ["name": "Central Brazilian", "code": "centralbrazilian"],
            ["name": "Chech", "code": "chech"],
            ["name": "Chee Kufta", "code": "cheekufta"],
            ["name": "Cheesesteaks", "code": "cheesesteaks"],
            ["name": "Chicken Shop", "code": "chickenshop"],
            ["name": "Chicken Wings", "code": "chicken_wings"],
            ["name": "Chilean", "code": "chilean"],
            ["name": "Chinese", "code": "chinese"],
            ["name": "Colombian", "code": "colombian"],
            ["name": "Comfort Food", "code": "comfortfood"],
            ["name": "Congee", "code": "congee"],
            ["name": "Conveyor Belt Sushi", "code": "conveyorsushi"],
            ["name": "Corsican", "code": "corsican"],
            ["name": "Creperies", "code": "creperies"],
            ["name": "Cuban", "code": "cuban"],
            ["name": "Cucina campana", "code": "cucinacampana"],
            ["name": "Curry Sausage", "code": "currysausage"],
            ["name": "Cypriot", "code": "cypriot"],
            ["name": "Czech", "code": "czech"],
            ["name": "Czech/Slovakian", "code": "czechslovakian"],
            ["name": "Danish", "code": "danish"],
            ["name": "Delis", "code": "delis"],
            ["name": "Dim Sum", "code": "dimsum"],
            ["name": "Diners", "code": "diners"],
            ["name": "Dominican", "code": "dominican"],
            ["name": "Donburi", "code": "donburi"],
            ["name": "Dumplings", "code": "dumplings"],
            ["name": "Eastern European", "code": "eastern_european"],
            ["name": "Eastern German", "code": "easterngerman"],
            ["name": "Eastern Mexican", "code": "easternmexican"],
            ["name": "Egyptian", "code": "egyptian"],
            ["name": "Emilian", "code": "emilian"],
            ["name": "Ethiopian", "code": "ethiopian"],
            ["name": "Fado Houses", "code": "fado_houses"],
            ["name": "Falafel", "code": "falafel"],
            ["name": "Fast Food", "code": "hotdogs"],
            ["name": "Filipino", "code": "filipino"],
            ["name": "Fischbroetchen", "code": "fischbroetchen"],
            ["name": "Fish & Chips", "code": "fishnchips"],
            ["name": "Flemish", "code": "flemish"],
            ["name": "Fondue", "code": "fondue"],
            ["name": "Food Court", "code": "food_court"],
            ["name": "Food Stands", "code": "foodstands"],
            ["name": "French", "code": "french"],
            ["name": "French Southwest", "code": "sud_ouest"],
            ["name": "Friulan", "code": "friulan"],
            ["name": "Fuzhou", "code": "fuzhou"],
            ["name": "Galician", "code": "galician"],
            ["name": "Gastropubs", "code": "gastropubs"],
            ["name": "Georgian", "code": "georgian"],
            ["name": "German", "code": "german"],
            ["name": "Giblets", "code": "giblets"],
            ["name": "Gluten-Free", "code": "gluten_free"],
            ["name": "Gozleme", "code": "gozleme"],
            ["name": "Greek", "code": "greek"],
            ["name": "Gyudon", "code": "gyudon"],
            ["name": "Haitian", "code": "haitian"],
            ["name": "Hakka", "code": "hakka"],
            ["name": "Halal", "code": "halal"],
            ["name": "Hand Rolls", "code": "handrolls"],
            ["name": "Hawaiian", "code": "hawaiian"],
            ["name": "Henghwa", "code": "henghwa"],
            ["name": "Hessian", "code": "hessian"],
            ["name": "Heuriger", "code": "heuriger"],
            ["name": "Himalayan/Nepalese", "code": "himalayan"],
            ["name": "Hokkien", "code": "hokkien"],
            ["name": "Hong Kong Style Cafe", "code": "hkcafe"],
            ["name": "Horumon", "code": "horumon"],
            ["name": "Hot Dogs", "code": "hotdog"],
            ["name": "Hot Pot", "code": "hotpot"],
            ["name": "Hunan", "code": "hunan"],
            ["name": "Hungarian", "code": "hungarian"],
            ["name": "Iberian", "code": "iberian"],
            ["name": "Indian", "code": "indpak"],
            ["name": "Indonesian", "code": "indonesian"],
            ["name": "International", "code": "international"],
            ["name": "Irish", "code": "irish"],
            ["name": "Island Pub", "code": "island_pub"],
            ["name": "Israeli", "code": "israeli"],
            ["name": "Italian", "code": "italian"],
            ["name": "Izakaya", "code": "izakaya"],
            ["name": "Jaliscan", "code": "jaliscan"],
            ["name": "Japanese", "code": "japanese"],
            ["name": "Japanese Curry", "code": "japacurry"],
            ["name": "Jewish", "code": "jewish"],
            ["name": "Kaiseki", "code": "kaiseki"],
            ["name": "Kebab", "code": "kebab"],
            ["name": "Korean", "code": "korean"],
            ["name": "Kosher", "code": "kosher"],
            ["name": "Kurdish", "code": "kurdish"],
            ["name": "Kushikatsu", "code": "kushikatsu"],
            ["name": "Laos", "code": "laos"],
            ["name": "Laotian", "code": "laotian"],
            ["name": "Latin American", "code": "latin"],
            ["name": "Lebanese", "code": "lebanese"],
            ["name": "Ligurian", "code": "ligurian"],
            ["name": "Live/Raw Food", "code": "raw_food"],
            ["name": "Lumbard", "code": "lumbard"],
            ["name": "Lyonnais", "code": "lyonnais"],
            ["name": "Madeira", "code": "madeira"],
            ["name": "Malaysian", "code": "malaysian"],
            ["name": "Mamak", "code": "mamak"],
            ["name": "Meatballs", "code": "meatballs"],
            ["name": "Mediterranean", "code": "mediterranean"],
            ["name": "Mexican", "code": "mexican"],
            ["name": "Middle Eastern", "code": "mideastern"],
            ["name": "Milk Bars", "code": "milkbars"],
            ["name": "Minho", "code": "minho"],
            ["name": "Modern Australian", "code": "modern_australian"],
            ["name": "Modern European", "code": "modern_european"],
            ["name": "Mongolian", "code": "mongolian"],
            ["name": "Moroccan", "code": "moroccan"],
            ["name": "Napoletana", "code": "napoletana"],
            ["name": "New Zealand", "code": "newzealand"],
            ["name": "Nicoise", "code": "nicois"],
            ["name": "Night Food", "code": "nightfood"],
            ["name": "Norcinerie", "code": "norcinerie"],
            ["name": "Northeastern Brazilian", "code": "northeasternbrazilian"],
            ["name": "Northern Brazilian", "code": "northernbrazilian"],
            ["name": "Northern German", "code": "northerngerman"],
            ["name": "Northern Mexican", "code": "northernmexican"],
            ["name": "Nyonya", "code": "nyonya"],
            ["name": "Oaxacan", "code": "oaxacan"],
            ["name": "Oden", "code": "oden"],
            ["name": "Okinawan", "code": "okinawan"],
            ["name": "Okonomiyaki", "code": "okonomiyaki"],
            ["name": "Onigiri", "code": "onigiri"],
            ["name": "Open Sandwiches", "code": "opensandwiches"],
            ["name": "Oriental", "code": "oriental"],
            ["name": "Oyakodon", "code": "oyakodon"],
            ["name": "Pakistani", "code": "pakistani"],
            ["name": "Palatine", "code": "palatine"],
            ["name": "Parent Cafes", "code": "eltern_cafes"],
            ["name": "Parma", "code": "parma"],
            ["name": "Pekinese", "code": "pekinese"],
            ["name": "Persian/Iranian", "code": "persian"],
            ["name": "Peruvian", "code": "peruvian"],
            ["name": "Piemonte", "code": "piemonte"],
            ["name": "Pierogis", "code": "pierogis"],
            ["name": "Pita", "code": "pita"],
            ["name": "Pizza", "code": "pizza"],
            ["name": "Polish", "code": "polish"],
            ["name": "Portuguese", "code": "portuguese"],
            ["name": "Potatoes", "code": "potatoes"],
            ["name": "Poutineries", "code": "poutineries"],
            ["name": "Provencal", "code": "provencal"],
            ["name": "Pub Food", "code": "pubfood"],
            ["name": "Pueblan", "code": "pueblan"],
            ["name": "Puerto Rican", "code": "puertorican"],
            ["name": "Ramen", "code": "ramen"],
            ["name": "Rhinelandian", "code": "rhinelandian"],
            ["name": "Ribatejo", "code": "ribatejo"],
            ["name": "Rice", "code": "riceshop"],
            ["name": "Robatayaki", "code": "robatayaki"],
            ["name": "Rodizios", "code": "rodizios"],
            ["name": "Roman", "code": "roman"],
            ["name": "Romanian", "code": "romanian"],
            ["name": "Rotisserie Chicken", "code": "rotisserie_chicken"],
            ["name": "Rumanian", "code": "rumanian"],
            ["name": "Russian", "code": "russian"],
            ["name": "Salad", "code": "salad"],
            ["name": "Salvadoran", "code": "salvadoran"],
            ["name": "Sandwiches", "code": "sandwiches"],
            ["name": "Sardinian", "code": "sardinian"],
            ["name": "Scandinavian", "code": "scandinavian"],
            ["name": "Scottish", "code": "scottish"],
            ["name": "Seafood", "code": "seafood"],
            ["name": "Senegalese", "code": "senegalese"],
            ["name": "Serbo Croatian", "code": "serbocroatian"],
            ["name": "Shanghainese", "code": "shanghainese"],
            ["name": "Sicilian", "code": "sicilian"],
            ["name": "Signature Cuisine", "code": "signature_cuisine"],
            ["name": "Singaporean", "code": "singaporean"],
            ["name": "Slovakian", "code": "slovakian"],
            ["name": "Soba", "code": "soba"],
            ["name": "Soul Food", "code": "soulfood"],
            ["name": "Soup", "code": "soup"],
            ["name": "South African", "code": "southafrican"],
            ["name": "Southern", "code": "southern"],
            ["name": "Spanish", "code": "spanish"],
            ["name": "Sri Lankan", "code": "srilankan"],
            ["name": "Steakhouses", "code": "steak"],
            ["name": "Sukiyaki", "code": "sukiyaki"],
            ["name": "Sushi Bars", "code": "sushi"],
            ["name": "Swabian", "code": "swabian"],
            ["name": "Swedish", "code": "swedish"],
            ["name": "Swiss Food", "code": "swissfood"],
            ["name": "Szechuan", "code": "szechuan"],
            ["name": "Tabernas", "code": "tabernas"],
            ["name": "Tacos", "code": "tacos"],
            ["name": "Taiwanese", "code": "taiwanese"],
            ["name": "Takoyaki", "code": "takoyaki"],
            ["name": "Tamales", "code": "tamales"],
            ["name": "Tapas Bars", "code": "tapas"],
            ["name": "Tapas/Small Plates", "code": "tapasmallplates"],
            ["name": "Tempura", "code": "tempura"],
            ["name": "Teochew", "code": "teochew"],
            ["name": "Teppanyaki", "code": "teppanyaki"],
            ["name": "Tex-Mex", "code": "tex-mex"],
            ["name": "Thai", "code": "thai"],
            ["name": "Tonkatsu", "code": "tonkatsu"],
            ["name": "Traditional Norwegian", "code": "norwegian"],
            ["name": "Traditional Swedish", "code": "traditional_swedish"],
            ["name": "Tras-os-Montes", "code": "tras_os_montes"],
            ["name": "Trattorie", "code": "trattorie"],
            ["name": "Trinidadian", "code": "trinidadian"],
            ["name": "Turkish", "code": "turkish"],
            ["name": "Turkish Ravioli", "code": "turkishravioli"],
            ["name": "Tuscan", "code": "tuscan"],
            ["name": "Udon", "code": "udon"],
            ["name": "Ukrainian", "code": "ukrainian"],
            ["name": "Unagi", "code": "unagi"],
            ["name": "Uzbek", "code": "uzbek"],
            ["name": "Vegan", "code": "vegan"],
            ["name": "Vegetarian", "code": "vegetarian"],
            ["name": "Venetian", "code": "venetian"],
            ["name": "Venezuelan", "code": "venezuelan"],
            ["name": "Venison", "code": "venison"],
            ["name": "Vietnamese", "code": "vietnamese"],
            ["name": "Western Style Japanese Food", "code": "westernjapanese"],
            ["name": "Wok", "code": "wok"],
            ["name": "Wraps", "code": "wraps"],
            ["name": "Yakiniku", "code": "yakiniku"],
            ["name": "Yakitori", "code": "yakitori"],
            ["name": "Yucatan", "code": "yucatan"],
            ["name": "Yugoslav", "code": "yugoslav"]
        ]
    }

    @IBAction func onCancelButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButtonClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var onCategories = [String]()
        for (index, value) in categoriesSwitchDictionary {
            if value {
                onCategories.append(categories[index]["code"]!)
            }
        }
        filtersDictionary["categories"] = onCategories
        filtersDictionary["sort"] = sortSegment.selectedSegmentIndex
        filtersDictionary["deals"] = dealSwitch.on
        delegate!.filtersViewController?(self, filtersDidChange: filtersDictionary)
    }
}
