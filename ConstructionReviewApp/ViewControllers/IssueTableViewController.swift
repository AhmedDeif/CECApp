//
//  IssueTableViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/19/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class IssueTableViewController: UITableViewController {

    // Improvements: show footer view when no results are present
    
    let cellReuseIdentifier = "IssueTableViewCell"
    let customHeaderIdentifier = "ProductDetailsHeaderView"
    let viewModel = ProjectIssuesViewModel()
    var project: ProjectModel?
    var projectIssues: [IssueModel] = [IssueModel]()
    var issuePosted: Bool = false
    var closedIssue = false
    var issueReopend = false
    var issueRated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.issuePosted {
            self.issuePosted = false
            fetchData() {
                self.view.makeToast("Your issue has been posted successfully")
            }
        }
        if self.issueReopend {
            self.issueReopend = false
            fetchData() {
                self.view.makeToast("Your issue has been re-opened successfully")
            }
        }

        if self.closedIssue {
            self.closedIssue = false
            fetchData() {
                self.view.makeToast("Your issue has been closed successfully")
            }
        }
        
        if self.issueRated {
            self.closedIssue = true
            fetchData() {
                self.view.makeToast("Your issue has been rated successfully")
            }
        }
        
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.mustRateIssueFlag.rawValue) {
            self.showRateIssueViewController()
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
        registerSectionHeadersFooters()
        self.tableView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 10,right: 0)
    }
    
    
    func registerCells() {
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    
    func registerSectionHeadersFooters() {
        tableView.register(UINib(nibName: customHeaderIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: customHeaderIdentifier)
    }


    
    func fetchData(sender: UIRefreshControl? = nil, completitonBlock: (()->())? = nil) {
        if NetworkManager.isConnectedToInternet() {
            if sender == nil {
                self.showLoadingIndicator()
            }
            viewModel.setProjectId(projectId: String(project!.id))
            viewModel.getProjectIssues { (requestSucceeded, error) in
                (sender == nil) ? self.hideLoadingIndicator() : sender?.endRefreshing()
                if requestSucceeded {
                    self.projectIssues = self.viewModel.projectIssues
                    self.tableView.reloadData()
                }
                else {
                    self.view.makeToast(error!.message)
                }
                completitonBlock?()
            }
        }
        else {
            self.view.makeToast("You are not connected to the internet")
        }
    }
    
    // MARK: - Table view data source

    
    @IBAction func refreshTable(_ sender: UIRefreshControl) {
        self.fetchData(sender: sender)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projectIssues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! IssueTableViewCell
        cell.setCellData(issue: self.projectIssues[indexPath.row])
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: customHeaderIdentifier) as! ProjectDetailsHeaderView
        header.delegate = self
        header.project = self.project
        header.setData()
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
        let controller = storyboard.instantiateViewController(withIdentifier: "issueViewContainer") as! IssueDetailsViewController
        controller.projectIssue = self.projectIssues[indexPath.row]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @IBAction func reportIssue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "reportIssueViewController") as! ReportIssueViewController
        controller.projectType = project?.getProjectType()
        controller.projectId = String(project!.id)
        self.issuePosted = false
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

}

extension IssueTableViewController: CustomHeaderDelegate {
    func didTapDetailsButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ProjectDescriptionViewController") as! ProjectDescriptionViewController
        viewController.project = self.project
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
}


