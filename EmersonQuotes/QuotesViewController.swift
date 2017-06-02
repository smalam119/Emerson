//
//  ViewController.swift
//  EmersonQuotes
//
//  Created by MacBook Pro 13" on 6/1/17.
//  Copyright © 2017 smalam119. All rights reserved.
//

import UIKit

class QuotesViewController: UIViewController {
    
    var observableStack = Stack()
    var quoteViewIndex = 0
    var quoteViewArray: [UIView]?
    
    @IBOutlet weak var quoteViewContainer: UIView!
    @IBOutlet weak var quoteNumberLabel: UILabel!
    @IBOutlet weak var quoteOneView: UIView!
    @IBOutlet weak var quoteTwoView: UIView!
    @IBOutlet weak var quoteThreeView: UIView!
    
    @IBAction func onPressBackButton(_ sender: Any) {
        if(observableStack.getSize() > 1) {
            hideUIView(uiView: (quoteViewArray?[quoteViewIndex])!)
            quoteViewIndex -= 1
            observableStack.pop()
        } else {
            print("can not go back")
        }
    }
    
    @IBAction func onPressNextButton(_ sender: Any) {
        if(quoteViewIndex < (quoteViewArray?.count)! - 1) {
            quoteViewIndex += 1
            observableStack.push((quoteViewArray?[quoteViewIndex])!)
        } else {
            print("no more views")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quoteViewArray = quoteViewContainer.subviews;
        makeAllViewInvisible()
        observableStack.push((quoteViewArray?[quoteViewIndex])!)
        observableStack.array.rx_elements().subscribe { event in
            switch event {
            case .next(let value):
                print("onNext\(value)")
                self.showUIView(uiView: value.last!)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeAllViewInvisible() {
        for view in quoteViewArray! {
            view.isHidden = true
        }
    }
    
    func showUIView(uiView: UIView) {
        uiView.isHidden = false
    }
    
    func hideUIView(uiView: UIView) {
        uiView.isHidden = true
    }
}

