//
//  CustomView.swift
//  SimpleSingleView
//
//  Created by Ari Braginsky on 1/3/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

import UIKit

class CustomView: UIView {

	override func awakeFromNib() {
		super.awakeFromNib()
		
		NSLog("CustomView.awakeFromNib")
		
		self.backgroundColor = UIColor.redColor()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func updateConstraints() {
		super.updateConstraints()
	}

	override func layoutSubviews() {
		super.layoutSubviews()
	}

	override func intrinsicContentSize() -> CGSize {
		return super.intrinsicContentSize()
	}
	
	override func didAddSubview(subview: UIView) {
		super.didAddSubview(subview)
	}
	
	override func willRemoveSubview(subview: UIView) {
		super.willRemoveSubview(subview)
	}
	
	override func willMoveToSuperview(newSuperview: UIView?) {
		super.willMoveToSuperview(newSuperview)
	}
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
	}
}

