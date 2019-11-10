//
//  NoteView.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 06/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

protocol NoteViewDelegate : class {
    /**
     Indicates that Note View should be dimissed
     */
    func dissmissNoteView()
    
    /**
     Indicates that Note has beed submitted
     */
    func noteAddedSuccessfully()
}

class NoteView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textViewNotes: UITextView!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var acativityIndicator: UIActivityIndicatorView!
    weak var delegate : NoteViewDelegate?
    var noteViewVM : NoteViewModeling! {
        didSet {
            self.noteViewVM.showError = { message in
                AppAlerts.showAlert(message: message)
            }
            
            self.noteViewVM.startIndicator = {[weak self] in
                self?.acativityIndicator.startAnimating()
            }
            
            self.noteViewVM.stopIndicator = {[weak self] in
                self?.acativityIndicator.stopAnimating()
            }
            
            self.noteViewVM.reloadMapView = {[weak self] in
                self?.delegate?.noteAddedSuccessfully()
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(NoteView.string, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    @IBAction func addNotesButtonAction(_ sender: Any) {
        noteViewVM.addNotes(title: textFieldTitle.text ?? "", notes: textViewNotes.text)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        delegate?.dissmissNoteView()
    }
    
    @IBAction func dissmissViewButtonAction(_ sender: Any) {
        endEditing(true)
        
    }
}
