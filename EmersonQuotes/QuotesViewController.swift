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
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func onPressNextButton(_ sender: Any) {
        
        //increment index and push an item into observable stack
        //on next button click
        quoteViewIndex += 1
        observableStack.push((quoteViewArray?[quoteViewIndex])!)
    }
    
    //decrement index hide the top item and pop
    @IBAction func onPressBackButton(_ sender: Any) {
        hideUIView(uiView: (quoteViewArray?[quoteViewIndex])!)
        quoteViewIndex -= 1
        observableStack.pop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteViewArray = quoteViewContainer.subviews;
        makeAllViewInvisible()
        observableStack.push((quoteViewArray?[quoteViewIndex])!)
        
        //subscribe to observable array
        //observer block
        _ = observableStack.array.rx_elements().subscribe { event in
            switch event {
            case .next(let value):
                //show show or hide item when pushed or poped from observable stack
                self.showUIView(uiView: value.last!)
                self.updateNavBarLabel(number: self.quoteViewIndex + 1)
                
                //controlling back and next button appearence and interection
                if(self.observableStack.getSize() == 1) {
                    self.disable(button: self.backButton)
                } else if(self.observableStack.getSize() == (self.quoteViewArray?.count)!) {
                    self.disable(button: self.nextButton)
                } else {
                    self.enableBackButton()
                    self.enableNextButton()
                }
                
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
    
    //initially make all view invisible
    func makeAllViewInvisible() {
        for view in quoteViewArray! {
            view.isHidden = true
        }
    }
    
    //show a particular view
    func showUIView(uiView: UIView) {
        uiView.isHidden = false
    }
    
    //hide a view
    func hideUIView(uiView: UIView) {
        uiView.isHidden = true
    }
    
    func updateNavBarLabel(number: Int) {
        quoteNumberLabel.text = "Quotes No.\(number)"
    }
    
    //disable a button
    func disable(button: UIButton) {
        button.setImage(nil, for: .normal)
        button.isUserInteractionEnabled = false
    }
    
    //enable back button
    func enableBackButton() {
        backButton.setImage(UIImage(named: "back") , for: .normal)
        backButton.isUserInteractionEnabled = true
    }
    
    //enable next button
    func enableNextButton() {
        nextButton.setImage(UIImage(named: "next") , for: .normal)
        nextButton.isUserInteractionEnabled = true
    }
}
