//
//  ConfigurationsTableViewController.swift
//  Frudder!
//
//  Created by Thomas Pratama Putra on 25/04/19.
//  Copyright © 2019 NA. All rights reserved.
//

import UIKit

class ConfigurationsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

}
