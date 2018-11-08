//
//  NibBasedView.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 11/7/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import UIKit

public typealias NibLoadableView = NibLoadable & UIView

public class NibBasedView: UIView {
    
    func commonInit() {
        let loaded = self.loadFromNib()
        loaded.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(loaded)
        
        self.addConstraints([
            loaded.topAnchor.constraint(equalTo: self.topAnchor),
            loaded.leftAnchor.constraint(equalTo: self.leftAnchor),
            loaded.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loaded.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    fileprivate func loadFromNib() -> UIView {
        fatalError("Must be overridden by subclasses")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
    }
}

@IBDesignable
public class DateTimePickerContainer: NibBasedView {
    
    public let view = DateTimePickerView.fromNib
    
    override func loadFromNib() -> UIView {
        return self.view
    }
    
    public override var intrinsicContentSize: CGSize {
        return self.view.intrinsicContentSize
    }
}




