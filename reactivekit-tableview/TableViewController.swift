//
//  ViewController.swift
//  reactivekit-tableview
//
//  Created by Markus Klepp on 01/07/16.
//  Copyright © 2016 mklepp. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit
import Fakery

class TableViewController: UITableViewController {
  
  struct RandomTitle {
    let title: String
    
    static func generate(count: Int = 1) -> [String]{
      let faker = Faker()
      var newItems: [String] = []
      for _ in 1...count {
        let title = faker.team.name()
        newItems.append(title)
      }
      return newItems
    }
  }
  
  var showAll: Bool = true
  
  let entries: CollectionProperty <[String]> = CollectionProperty([])
  let filteredItems: CollectionProperty <[String]> = CollectionProperty([])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.entries.replace(RandomTitle.generate(5))
    
    self.filterCollection()
    
    filteredItems.bindTo(tableView) { indexPath, randomStrings, tableView in
      let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
      let randomString = randomStrings[indexPath.row]
      cell.textLabel!.text = randomString
      return cell
    }
  }
  
  func filterCollection(){
    entries.filter{ randomString in
      return self.showAll || randomString.hash%2 == 0
      }.bindTo(filteredItems)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func reload(sender: AnyObject) {
    
    let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
    dispatch_after(time, dispatch_get_main_queue()) {
      
      let numEntries = Int(arc4random_uniform(10) + 5)
      self.entries.replace(RandomTitle.generate(numEntries))
      
      
      self.refreshControl?.endRefreshing()
    }
    
  }
  
  @IBAction func filter(sender: AnyObject) {
    showAll = false
    self.filterCollection()
  }
  
  @IBAction func noFilter(sender: AnyObject) {
    showAll = true
    self.filterCollection()
  }
  
  func getRow(indexPath: NSIndexPath, randomStrings: [String], tableView: UITableView) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
    let randomString = randomStrings[indexPath.row]
    cell.textLabel!.text = randomString
    return cell
  }
  
  @IBAction func add(sender: AnyObject) {
    self.entries.append(RandomTitle.generate().first!)
  }
  
  @IBAction func remove(sender: AnyObject) {
    self.entries.removeLast()
  }
}