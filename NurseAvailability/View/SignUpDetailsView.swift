//
//  SignUpDetailsView.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 20/05/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import UIKit

class SignUpDetailsView: UIView {
    var inputTextLabels: [UILabel] = []
    
    func showTextFieldLabel(text: String) {
        let startingYPosition = (inputTextLabels.last?.frame.origin.y).map {
            $0 + 40
            } ?? 0
        
        let inputDetailsLabel = UILabel(frame: CGRect(x: 0, y: startingYPosition, width: frame.width, height: 40))
        inputDetailsLabel.text = text
        inputDetailsLabel.textAlignment = .Center
        inputTextLabels.append(inputDetailsLabel)
        addSubview(inputDetailsLabel)
    }
}
