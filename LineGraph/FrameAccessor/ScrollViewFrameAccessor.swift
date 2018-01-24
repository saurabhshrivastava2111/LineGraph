//
//  ScrollViewFrameAccessor.swift
//  LineGraph
//
//  Created by Saurabh Kumar on 1/23/18.
//  Copyright © 2018 Saurabh Kumar. All rights reserved.
//

import UIKit
extension UIScrollView{
    //MARK:-  Content Offset
    func contentOffsetX()->CGFloat{
        return self.contentOffset.x
    }
    
    func contentOffsetY()->CGFloat{
        return self.contentOffset.y
    }
    
    
    func setContentOffsetX(newCOntentOffsetX:CGFloat){
        
        self.contentOffset = CGPoint.init(x: newCOntentOffsetX, y: self.contentOffsetY())
    }
    
    func setCOntentOffsetY(newContentOffsetY:CGFloat){
        self.contentOffset = CGPoint.init(x: self.contentOffsetX(), y: newContentOffsetY)
    }
    
    //MARK:- Content Size
    
    func contentSizeWidth()-> CGFloat{
        return self.contentSize.width
    }
    
    func contentSizeHeight()->CGFloat{
        return self.contentSize.height
    }
    
    func setCOntentSizeWidth(newContentWidth:CGFloat){
        self.contentSize = CGSize.init(width: newContentWidth, height: self.contentSizeHeight())
    }
    
    func setCOntentSizeHeight(newContentHeight:CGFloat){
        self.contentSize = CGSize.init(width: self.contentSizeWidth(), height: newContentHeight)
    }
    
    //MARK:- Content Inset
    
    
    func contentInsetTop()->CGFloat{
        return self.contentInset.top
    }
    
    func contentInsetRight()->CGFloat{
        return self.contentInset.right
    }
    
    func contentInsetBottom()->CGFloat{
        return self.contentInset.bottom
    }
    
    func contentInsetLeft()-> CGFloat{
        return self.contentInset.left
    }
    
    func setContentInsetTop(newContgentInsetTop: CGFloat){
        var newContentInset = self.contentInset
        newContentInset.top = newContgentInsetTop
        self.contentInset = newContentInset
    }
    func setContentInsetRight(newContgentInsetRight: CGFloat){
        var newContentInset = self.contentInset
        newContentInset.right = newContgentInsetRight
        self.contentInset = newContentInset
    }
    
    func setContentInsetBottom(newContgentInsetBottom: CGFloat){
        var newContentInset = self.contentInset
        newContentInset.bottom = newContgentInsetBottom
        self.contentInset = newContentInset
    }
    
    func setContentInsetLeft(newContgentInsetLeft: CGFloat){
        var newContentInset = self.contentInset
        newContentInset.left = newContgentInsetLeft
        self.contentInset = newContentInset
    }
}
