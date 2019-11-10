//
//  NotesTVC.swift
//  Landmark Remark
//
//  Created by Adnan Munir on 08/11/2019.
//  Copyright © 2019 Adnan Munir. All rights reserved.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    
    func configureCell(with note : Note) {
        labelTitle.text = "Title : \(note.title ?? "")"
        labelNote.text = "Note : \(note.note ?? "")"
        labelUserName.text = "UserName : \(note.username ?? "")"
    }
    

}
