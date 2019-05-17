//
//  TextField_Date.swift
//  Auditions
//
//  Created by Warren O'Brien on 4/9/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.
//

import UIKit

/// Date text field delegate protocol

@objc protocol TimeFieldDelegate {
    @objc optional
    func dateTextField(_ dateTextField: TextField_Time, didChangeDate: Date?)
    
    @objc optional
    func didTapDone(dateTextField: TextField_Time)
}

/// Date text field
///
/// Used for entry of dates in UITextField, replacing keyboard with date picker.

class TextField_Time: UITextField {
    
    /// `DateTextField` delegate
    ///
    /// You don't need to supply a delegate, but if you do, this will tell you as
    /// the user changes the date.
    
    weak var dateFieldDelegate: TimeFieldDelegate?
    
    /// Default date
    ///
    /// If `nil`, uses today's date
    
    var defaultDate: Date?
    
    /// Date formatter for date
    ///
    /// Feel free to change `dateStyle` and `timeStyle` to suit the needs of your app.
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    /// Date
    ///
    /// The user's selected date.
    
    var date: Date? {
        didSet {
            dateFieldDelegate?.dateTextField?(self, didChangeDate: date)
            if !isManuallyEditing {
                text = date.map { formatter.string(from: $0) }
            }
            datePicker.date = date ?? defaultDate ?? Date()
        }
    }
    
    var dateFieldButtonType: DateFieldButtonType = .done {
        didSet { doneButton?.title = dateFieldButtonType.buttonText }
    }
    
    /// The date picker.
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        return picker
    }()
    
    // MARK: - Private properties
    
    /// Private reference for "Done" button
    
    private var doneButton: UIBarButtonItem!
    
    /// Private flag is the user is manually changing the date.
    
    private var isManuallyEditing = false
    
    // MARK: - Initialization
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
}

// MARK: - Private utility methods

private extension TextField_Time {
    func configure() {
        inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerModified(_:)), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        doneButton = UIBarButtonItem(title: dateFieldButtonType.buttonText, style: .done, target: self, action: #selector(didTapDone(_:)))
        
        clearButtonMode = .whileEditing
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        inputAccessoryView = toolBar
        
        addTarget(self, action: #selector(dateFieldModified(_:)), for: .editingChanged)
    }
}

// MARK: - Actions

extension TextField_Time {
    @objc func didTapDone(_ sender: Any) {
        if dateFieldButtonType == .select {
            date = datePicker.date
        }
        
        resignFirstResponder()
        
        dateFieldDelegate?.didTapDone?(dateTextField: self)
    }
    
    @objc func dateFieldModified(_ textField: UITextField) {
        isManuallyEditing = true
        date = text.flatMap { formatter.date(from: $0) }
        isManuallyEditing = false
    }
    
    @objc func datePickerModified(_ datePicker: UIDatePicker) {
        date = datePicker.date
    }
}

// MARK: - Enumerations

extension TextField_Time {
    enum DateFieldButtonType {
        case select
        case done
        case next
    }
}

extension TextField_Time.DateFieldButtonType {
    var buttonText: String {
        switch self {
        case .select: return NSLocalizedString("Select", comment: "DateTextFieldButtonType")
        case .done:   return NSLocalizedString("Done",   comment: "DateTextFieldButtonType")
        case .next:   return NSLocalizedString("Next",   comment: "DateTextFieldButtonType")
        }
    }
}
