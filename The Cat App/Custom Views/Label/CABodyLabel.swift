//
//  CABodyLabel.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import UIKit

class CABodyLabel: UILabel {
    
    //MARK:- properties
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    //MARK:- custom actions
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .subheadline)
        sizeToFit()
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
    }
}
