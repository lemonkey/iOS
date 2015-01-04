//
//  ViewController.swift
//  SimpleSingleView
//
//  Created by Ari Braginsky on 1/3/15.
//  Copyright (c) 2015 Guidance Is Internal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var customView:CustomView!
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		NSLog("ViewController.viewDidLoad")
//		
//		let frame:CGRect = CGRectMake(0, 0, 100, 100)
//		let aView:CustomView = CustomView(frame: frame)
//
//		self.view.addSubview(aView)
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated);
		
		NSLog("ViewController.viewWillAppear")
	}
}

