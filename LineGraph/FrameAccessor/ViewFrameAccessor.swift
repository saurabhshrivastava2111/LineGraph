//
//  ViewFrameAccessor.swift
//  LineGraph
//
//  Created by Saurabh Kumar on 1/23/18.
//  Copyright © 2018 Saurabh Kumar. All rights reserved.
//

import UIKit

extension UIView {
    //MARK:- Frame
    func setOrigin(origin:CGPoint){
        self.frame.origin = origin
    }
    
    func origin()->CGPoint{
        return self.frame.origin
    }
    
    func setSize(newSize:CGSize){
        self.frame.size = newSize
    }
    
    
    func size()->CGSize{
        return self.frame.size
    }
    
    
    
    func x()->CGFloat{
        return self.frame.origin.x
    }
    
    func y()->CGFloat{
        return self.frame.origin.y
    }
    
    func setX(newX:CGFloat){
        var frame = self.frame
        frame.origin.x = newX
        self.frame = frame
    }
    
    
    func setY(newY:CGFloat){
        var frame = self.frame
        frame.origin.y = newY
        self.frame = frame
        
    }
    
    // MARK:- Size
    func height()->CGFloat{
        return self.frame.size.height
    }
    
    func setHeight(newHeight:CGFloat){
        var frame = self.frame
        frame.size.height = newHeight
        self.frame = frame
    }
    
    func width()->CGFloat{
        return self.frame.size.height
    }
    
    func setWidth(newWidth:CGFloat){
        var frame = self.frame
        frame.size.width = newWidth
        self.frame = frame
    }
    
    //MARK:- Borders
    func left()->CGFloat{
        return self.x()
    }
    
    func setLeft(left:CGFloat){
        self.setX(newX: left)
    }
    
    func right()->CGFloat{
        return self.x() + self.width()
    }
    
    func setRight(right:CGFloat){
        self.setX(newX: (self.right() - self.width()))
    }
    
    func top()->CGFloat{
        return self.y()
    }
    
    func setTop(top:CGFloat){
        self.setY(newY: top)
    }
    
    
    func bottom()->CGFloat{
        return self.y() + self.height()
    }
    
    func setBottom(){
        self.setY(newY: self.bottom() + self.height())
    }
 
    
    func centerX()->CGFloat{
        return self.center.x
    }
    
    func setCenterX(newCenterX:CGFloat){
        self.center = CGPoint.init(x: newCenterX, y: self.center.y)
    }
    
    
    func centerY()->CGFloat{
        return self.center.y
    }
    
    
    
    func setCenterY(newCenterY:CGFloat){
        self.center = CGPoint.init(x: self.centerX(), y: newCenterY)
    }
    
    func middleX()->CGFloat{
        return self.width() / 2.0
    }
    
    
    func middleY()-> CGFloat{
        return self.height() / 2.0
    }
    
    
    func middlePOint()->CGPoint{
        return CGPoint.init(x: self.middleX(), y: self.middleY())
    }

    

    
}
