//
//  AvailabilityViewController.swift
//  NurseAvailability
//
//  Created by Kiera O'Reilly on 10/07/2016.
//  Copyright © 2016 Marks and Spencer. All rights reserved.
//

import UIKit

class AvailabilityViewController: CKCalendarViewController, CKCalendarViewDataSource {
    let calendar = CKCalendarViewController()
    var data : NSMutableDictionary = NSMutableDictionary()
    
    convenience init() {
        self.init()
        self.data = NSMutableDictionary()
    }
    
    required init?(coder aDecoder: NSCoder) {
        data = NSMutableDictionary()
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.data = NSMutableDictionary()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let title: NSString = NSLocalizedString("Swift Demo", comment: "")
        let date: NSDate = NSDate(day: 26, month: 7, year: 2016)
        let event: CKCalendarEvent = CKCalendarEvent(title: title as String, andDate: date, andInfo: nil)
        
        self.data[date] = [event]
        
    }
    
    func calendarView(calendarView: CKCalendarView!, eventsForDate date: NSDate!) -> [AnyObject]! {
        
        return self.data.objectForKey(date) as! [AnyObject]!
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.presentViewController(calendar, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
