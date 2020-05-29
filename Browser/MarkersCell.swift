//
//  MarkersCell.swift
//  Browser
//
//  Created by Alexandr Kulya on 27.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit

class MarkersCell: UITableViewCell {
    
    var setupValue: Marker? {
        didSet {
            self.textLabel?.text = setupValue?.text
        }
    }
}
