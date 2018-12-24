//
//  ProjectsTableViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/15/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ProjectsTableViewController: UITableViewController {
    
    
    let cellReuseIdentifier = "ProjectTableViewCell"
    var viewModel = ProjectsViewModel()
    var projectList: [ProjectModel] = [ProjectModel]()
    var issueRated: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.mustRateIssueFlag.rawValue) {
            self.showRateIssueViewController()
        }
        if self.issueRated {
            self.issueRated = false
            self.view.makeToast("Your issue has been rated successfully")
        }
    }
    
    
    func fetchData(sender: UIRefreshControl? = nil) {
        if NetworkManager.isConnectedToInternet() {
            if sender == nil {
                self.startAnimating()
            }
            viewModel.getListOfProjects { error in
                (sender == nil) ? self.stopAnimating() : sender?.endRefreshing()
                self.stopAnimating()
                if error != nil {
                    self.view.makeToast(error!.message)
                }
                else {
                    // ToDo: update Table
                    self.projectList = self.viewModel.projects
                    self.tableView.reloadData()
                }
            }
        }
        else {
            self.view.makeToast("You are not connected to the internet")
        }
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
        self.tableView.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 10,right: 0)
    }
    
    func registerCells() {
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    @IBAction func refreshTable(_ sender: UIRefreshControl) {
        fetchData(sender: sender)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ProjectTableViewCell
        cell.setData(project: self.projectList[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Launch issue VC
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "issueTableViewController") as! IssueTableViewController
        controller.project = self.projectList[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

}
