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
    
    mutating func push(_ uiView: UIView) {
        array.append(uiView);
    }
    
    mutating func pop() {
        array.popLast();
    }
    
    func peek() -> UIView? {
        return array.count != 0 ? array[array.count-1] : nil;
        
    }
    
    func getSize() -> Int {
        return array.count;
    }
    
}
