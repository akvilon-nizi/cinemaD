//
//  RegionContentManager.swift
//  foodle
//
//  Created by incetro on 24/08/2017.
//  Copyright © 2017 Heads and Hands. All rights reserved.
//

import UIKit

// MARK: - RegionContentManager

class RegionContentManager: NSObject {

    weak var delegate: RegionContentManagerDelegate?

    var selectedRegion: Region? {

        guard let index = tableView?.indexPathForSelectedRow?.row else {

            return nil
        }

        return regions[index]
    }

    var regions: [Region] = [] {

        didSet {

            tableView?.reloadData()
        }
    }

    var tableView: UITableView? {

        didSet {

            tableView?.dataSource = self
            tableView?.delegate = self
            tableView?.register(RegionCell.self)
        }
    }
}

// MARK: - UITableViewDataSource

extension RegionContentManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return regions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: RegionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

        cell.setData(region: regions[indexPath.row])

        return cell
    }
}

// MARK: - UITableViewDelegate

extension RegionContentManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        delegate?.didSelectRegion(regions[indexPath.row])
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 65
    }
}
