//
//  Stack.swift
//  EmersonQuotes
//
//  Created by MacBook Pro 13" on 6/2/17.
//  Copyright © 2017 smalam119. All rights reserved.
//

import Foundation
import ObservableArray_RxSwift
import UIKit

struct Stack {
    var array: ObservableArray<UIView> = []
    
    //function to push a item into the observable array
    mutating func push(_ uiView: UIView) {
        array.append(uiView);
    }
    
    //function to pop a item
    mutating func pop() {
        array.popLast();
    }
    
    //check the top most item
    func peek() -> UIView? {
        return array.count != 0 ? array[array.count-1] : nil;
        
    }
    
    //get the array size
    func getSize() -> Int {
        return array.count;
    }
    
}
