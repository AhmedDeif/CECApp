//
//  ReportIssueViewController.swift
//  ConstructionReviewApp
//
//  Created by Ahmed Abodeif on 11/22/18.
//  Copyright © 2018 Ahmed Abodeif. All rights reserved.
//

import UIKit

class ReportIssueViewController: UIViewController,issueImageDeletionProtocol {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var issueImagesCollectionView: UICollectionView!
    @IBOutlet weak var issueReportView: UIView!
    @IBOutlet weak var issueTypeSelectionLabel: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var issueDescriptionTextView: UITextView!
    
    @IBOutlet weak var reportIssueButton: UIButton!
    
    let collectionViewCellReuseIdentifier = "reportIssueCollectionViewCell"
    var issueImages = [UIImage]()
    
    let issueTypes = ["", "type 1", "type 2", "type 3", "type 4"]
    
    var constructionIssueTypes = ["", "misbehavior", "quality non-conformance", "time delay", "change response delay", "safety concern", "maintenance issues"]
    var supportIssueTypes = ["" ,"Finishes", "Sanitary", "Electrical", "Fire Fighting", "HVAC", "Elevators"]
    let isseuTypePickerView = UIPickerView()
    weak var activeTextView: UITextView?
    var scrollViewLastOffset: CGPoint?

    var textViewPlaceholderActive = true
    let textViewPlaceholderText = "Issue description"
    var projectType: ProjectModel.projectType?
    var projectId: String?
    
    let viewModel = IssueViewModel()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
        self.view.setBackgroudAsGradient()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        setPickerInput()
        setTextViewKeyboard()
        issueTypeSelectionLabel.delegate = self
        issueDescriptionTextView.delegate = self
        self.scrollView.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReportIssueViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        viewModel.setProjectId(projectId: self.projectId!)
        viewModel.projectType = self.projectType
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    func styleView() {
        self.issueReportView.layer.cornerRadius = 5
        self.reportIssueButton.layer.cornerRadius = self.reportIssueButton.frame.height / 2
    }

    
    func setPickerInput() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ReportIssueViewController.pickerSelection))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.issueTypeSelectionLabel.inputView = isseuTypePickerView
        self.issueTypeSelectionLabel.inputAccessoryView = toolBar
        isseuTypePickerView.delegate = self
        isseuTypePickerView.dataSource = self
    }
    
    func setTextViewKeyboard() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ReportIssueViewController.KeyboardDoneButtonHandler))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.issueDescriptionTextView.inputAccessoryView = toolBar
    }

    
    
    @objc func pickerSelection() {
        issueTypeSelectionLabel.resignFirstResponder()
    }
    
    
    @objc func KeyboardDoneButtonHandler() {
        issueDescriptionTextView.resignFirstResponder()
    }
    
    
    @IBAction func addImageButtonClick(_ sender: Any) {
        let cameraHandler = CameraHandler.shared()
        cameraHandler.setHandlerParams(viewController: self) { (selectedImage) in
            self.issueImages.append(selectedImage)
            self.issueImagesCollectionView.reloadData()
        }
        cameraHandler.showActionSheet()
    }
    
    
    func deleteImage(indexPath: Int) {
        self.issueImages.remove(at: indexPath)
        self.issueImagesCollectionView.reloadData()
    }
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    
    
    @objc func keyboardWasShown(notification: NSNotification) {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.isScrollEnabled = false
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        let activeTextFieldRect: CGRect? = self.view.window?.convert(issueDescriptionTextView.frame, from: issueDescriptionTextView)
        let maxPoint: CGPoint? = CGPoint(x: (activeTextFieldRect?.maxX)!, y: (activeTextFieldRect?.maxY)! )
        if self.activeTextView != nil {
            if (!aRect.contains(maxPoint!)){
                self.scrollView.scrollRectToVisible(activeTextFieldRect!, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        //Once keyboard disappears, restore original positions
        var info = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.isScrollEnabled = true
    }
    
    func issueFieldsValid() -> Bool {
        if textViewPlaceholderActive {
            self.view.makeToast("You must add issue description")
            return false
        }
        
        if !issueTypeSelectionLabel.hasText {
            self.view.makeToast("Please select your issue type")
            return false
        }
        return true
    }
    
    
    @IBAction func reportIssueTapped(_ sender: Any) {
        if issueFieldsValid() {
            viewModel.issueType = self.issueTypeSelectionLabel.text!
            viewModel.issueDescription = self.issueDescriptionTextView.text!
            viewModel.issueImages = self.issueImages
            self.showLoadingIndicator()
            viewModel.createIssue { (error) in
                self.hideLoadingIndicator()
                guard let errorType = error else {
                    let viewControllersStack = self.navigationController!.viewControllers
                    let parent = viewControllersStack[viewControllersStack.count - 2] as! IssueTableViewController
                    parent.issuePosted = true
                    self.navigationController?.popViewController(animated: true)
                    return
                }
                self.view.makeToast(errorType.message)
            }
        }
    }
    

}


extension ReportIssueViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issueImages.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseIdentifier, for: indexPath) as! reportIssueCollectionViewCell
            cell.setImage(image: self.issueImages[indexPath.row])
        cell.viewController = self
        cell.indexPath = indexPath.row
        return cell
    }
}



extension ReportIssueViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.projectType! {
        case .Construction:
            issueTypeSelectionLabel.text = constructionIssueTypes[row]
        case .Support:
            issueTypeSelectionLabel.text = supportIssueTypes[row]
        }
    }
    
}



extension ReportIssueViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.projectType == .Construction {
            return constructionIssueTypes.count
        }
        if self.projectType == .Support {
            return supportIssueTypes.count
        }
        return issueTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.projectType == .Construction {
            return constructionIssueTypes[row]
        }
        if self.projectType == .Support {
            return supportIssueTypes[row]
        }
        return issueTypes[row]
    }
    
}




extension ReportIssueViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textViewPlaceholderActive {
            self.textViewPlaceholderActive = false
            self.issueDescriptionTextView.text = ""
        }
        self.activeTextView = textView
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if !issueDescriptionTextView.hasText {
            self.textViewPlaceholderActive = true
            self.issueDescriptionTextView.text = self.textViewPlaceholderText
            return true
        }
        textView.resignFirstResponder()
        self.activeTextView = nil
        return true
    }

}



extension ReportIssueViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == issueTypeSelectionLabel {
            let selectedRow = self.isseuTypePickerView.selectedRow(inComponent: 0)
            if selectedRow > -1 {
                self.isseuTypePickerView.selectRow(selectedRow, inComponent: 0, animated: false)
            }
            else {
                self.isseuTypePickerView.selectRow(0, inComponent: 0, animated: false)
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}




