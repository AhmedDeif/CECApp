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
    
    let collectionViewCellReuseIdentifier = "reportIssueCollectionViewCell"
    var issueImages = [UIImage]()
    let issueTypes = ["", "type 1", "type 2", "type 3", "type 4"]
    let isseuTypePickerView = UIPickerView()
    weak var activeTextView: UITextView?
    var scrollViewLastOffset: CGPoint?

    
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
        setData()
        styleView()
        setPickerInput()
        issueTypeSelectionLabel.delegate = self
        issueDescriptionTextView.delegate = self
        self.scrollView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReportIssueViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    func setData() {
        issueImages.append(#imageLiteral(resourceName: "key"))
        issueImages.append(#imageLiteral(resourceName: "key"))
        issueImages.append(#imageLiteral(resourceName: "key"))
        issueImages.append(#imageLiteral(resourceName: "key"))
        issueImages.append(#imageLiteral(resourceName: "key"))
    }
    
    func styleView() {
        self.issueReportView.layer.cornerRadius = 5
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

    
    @objc func pickerSelection() {
        issueTypeSelectionLabel.resignFirstResponder()
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
    


}

extension ReportIssueViewController: UICollectionViewDelegate {
    
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
        issueTypeSelectionLabel.text = issueTypes[row]
    }
    
}

extension ReportIssueViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return issueTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return issueTypes[row]
    }
    
}


extension ReportIssueViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.activeTextView = textView
        return true
    }
    
}

extension ReportIssueViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == issueTypeSelectionLabel {
            let selectedRow = self.isseuTypePickerView.selectedRow(inComponent: 0)
            print(selectedRow)
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




