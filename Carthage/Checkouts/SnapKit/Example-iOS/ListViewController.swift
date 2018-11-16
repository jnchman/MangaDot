//
//  ViewController.swift
//  Example-iOS
//
//  Created by Spiros Gerokostas on 01/03/16.
//  Copyright © 2016 SnapKit Team. All rights reserved.
//

import SnapKit
import UIKit

class ListViewController: UITableViewController {
    let kCellIdentifier = "CellIdentifier"
    let demos = ["Simple Layout", "Basic UIScrollView"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "SnapKit iOS Demos"

        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return demos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier)! as UITableViewCell

        cell.textLabel?.text = demos[indexPath.row]

        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController = SimpleLayoutViewController()
            navigationController?.pushViewController(viewController, animated: true)
        } else if indexPath.row == 1 {
            let viewController = ViewController()
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
