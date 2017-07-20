//
//  NumbersTableViewController.swift
//  StickyHeaderDemo
//
//  Created by 默司 on 2017/7/20.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class NumbersTableViewController: UITableViewController {

    var count: Int!
    
    convenience init(count: Int) {
        self.init()
        self.count = count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SimpleCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }

}
