//
//  IssueTableViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/19/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssueTableViewController: UITableViewController {

    let cellReuseIdentifier = "IssueTableViewCell"
    let customHeaderIdentifier = "ProductDetailsHeaderView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpTableView() {
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.showsVerticalScrollIndicator = false
        registerCells()
        registerSectionHeadersFooters()
        self.tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 10,right: 0)
    }
    
    func registerCells() {
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func registerSectionHeadersFooters() {
        tableView.register(UINib(nibName: customHeaderIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: customHeaderIdentifier)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! IssueTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderIdentifier) as! ProjectDetailsHeaderView
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "issueDetailsViewController") as! IssueImagesCollectionViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }


}

extension IssueTableViewController: CustomHeaderDelegate {
    func didTapDetailsButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProjectDescriptionViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
}


