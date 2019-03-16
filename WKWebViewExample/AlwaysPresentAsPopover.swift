//
//  AlwaysPresentAsPopover.swift
//  WKWebViewExample
//
//  Created by Apple on 2019/3/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class AlwaysPresentAsPopover : NSObject, UIPopoverPresentationControllerDelegate {
    
    private static let sharedInstance = AlwaysPresentAsPopover()
    
    private override init() {
        super.init()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    static func configurePresentation(forController controller : UIViewController) -> UIPopoverPresentationController {
        controller.modalPresentationStyle = .popover
        let presentationController = controller.presentationController as! UIPopoverPresentationController
        presentationController.delegate = AlwaysPresentAsPopover.sharedInstance
        return presentationController
    }
    
}
