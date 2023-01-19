//
//  ViewController.swift
//  Age Calculator
//
//  Created by Shamita Gurusu on 5/31/20.
//  Copyright © 2020 Shamita Gurusu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var input: UITextField!
    
    var dob = ""
    var dobM = ""
    var dobD = ""
    var dobY = ""
    
    @IBOutlet weak var base: UIView!
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 3
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 75)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        showDatePicker()
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        
        //
        let calender = Calendar.current
        let date = Date()
        let finalDate = calender.date(byAdding: Calendar.Component.day, value: 0, to: date)
        
        if let FinalDate = finalDate{
            datePicker.maximumDate = FinalDate
        }
        //
        input.inputAccessoryView = toolbar
        input.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        input.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setText()
    }
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    
    private func setText()
    {
        base.addSubview(resultLabel)
        resultLabel.frame = CGRect(x:0, y: base.frame.size.height / 2, width: base.frame.size.width, height: base.frame.size.height/2)
    }
    
    @IBAction func Age(_ sender: Any)
    {
        //let date = "\(datePicker?.date)"
        
        dob = "\(input.text)"
        
        if (dob.count == 12 )
        {
            showAlert()
            return
        }
        else
        {
            dobM = String(dob[String.Index.init(encodedOffset: 10)..<String.Index.init(encodedOffset: 12)])
            dobD = String(dob[String.Index.init(encodedOffset: 13)..<String.Index.init(encodedOffset: 15)])
            dobY = String(dob[String.Index.init(encodedOffset: 16)..<String.Index.init(encodedOffset: 20)])
            
            let months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            var year =  Int(String(components.year!))!
            var month = Int(String(components.month!))!
            var day = Int(String(components.day!))!
            
            
            
            let dM = Int(dobM)!
            let dD = Int(dobD)!
            let dY = Int(dobY)!
            
            var m  = 0
            var d = 0
            var y = 0
            
            
            
            
            if (dD > day)
            {
                month = month - 1
                day = day + months[dM - 1]
            }
            
            if (dM > month)
            {
                year = year - 1
                month = month + 12
            }
            
            d = day - dD
            m = month - dM
            y = year - dY
            
            
            resultLabel.text = "\(y) year(s) \n \(m) month(s) \n \(d) day(s)"
        }
        
        
        
        
    }
    
    func showAlert()
    {
        let alertView = UIAlertController(title: "Invalid Input", message: "Please enter a valid date of birth", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
}

