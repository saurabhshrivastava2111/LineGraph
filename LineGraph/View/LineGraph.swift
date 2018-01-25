//
//  LineGraph.swift
//  LineGraph
//
//  Created by Saurabh Kumar on 1/22/18.
//  Copyright © 2018 Saurabh Kumar. All rights reserved.
//

import UIKit

protocol GraphDataSource:class{
    func numberOfLines() -> Int
    func colorForLine(at index:Int)-> UIColor
    func valueForLine(at index:Int) -> [Any]?
    
    func animateDurationForLine(at index:Int) -> CFTimeInterval
    func titleForLine(at index:Int) -> String?
}

let defaultLabelWidth:CGFloat = 40.0
let defaultLabelHeight:CGFloat = 12.0
let defaultLabelCount = 5

let defaultLineWidth:CGFloat = 3.0
let defaultMargin: CGFloat = 10.0
let defaultMarginBottom:CGFloat = 20.0

let  axisMargin:CGFloat = 50.0;

class LineGraph:UIView {
    
    var animated: Bool = false
    weak var dataSource: GraphDataSource?
    var animatedDuration: CFTimeInterval?
    var lineWidth: CGFloat!
    var margin: CGFloat!
    var valueLabelCount: Int!
//    var minValue: CGFloat!
    var startsFromZero:Bool = true
    
    private var titleLabels:[Any] = [Any]()
    private var valueLabels:[Any] = [Any]()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.animated  = true
        self.animatedDuration = 1.0
        self.lineWidth = defaultLineWidth
        self.margin = defaultMargin
        self.valueLabelCount = defaultLabelCount
        self.clipsToBounds = true
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.animated  = true
        self.animatedDuration = 1.0
        self.lineWidth = defaultLineWidth
        self.margin = defaultMargin
        self.valueLabelCount = defaultLabelCount
        self.clipsToBounds = true
        
    }
    
    func draw(){
        if self.hasTitleLabels() {
            self.titleLabels.removeAll()
        }
        
        self.constructTitleLabels()
        self.positionTitleLabels()
        
        if hasValueLabels() {
            self.valueLabels.removeAll()
        }
        self.constructValueLabels()
        
        self.drawLines()
        
    }
    
    func drawLines(){
        
        if let numberOfLines = self.dataSource?.numberOfLines() {
            for anIndex in 0..<numberOfLines {
                self.drawLine(at: anIndex)
            }
        }
    }
    
    //This method
    func refresh(){
        
    }
    
    func constructValueLabels(){
        let count = self.valueLabelCount
        var items:[Any] = [Any]()
        
        for anIndex in 0..<count!{
            let frame = CGRect.init(x: 0, y: 0, width: defaultLabelWidth, height: defaultLabelHeight)
            let lblAnItem:UILabel = UILabel.init(frame: frame)
            lblAnItem.textAlignment = .right
            lblAnItem.font = UIFont.boldSystemFont(ofSize: 12.0)
            lblAnItem.textColor = UIColor.lightGray
            
            var value = self.minValue() + (CGFloat(anIndex) * self.stepValueLabelY())
            
            lblAnItem.text = "\(ceil(value))"
            
            value = self.positionYFor(line: value)
            
            lblAnItem.setCenterY(newCenterY: value)
            self.drawHorizontalLine(at: value)
            self.addSubview(lblAnItem)

            items.append(lblAnItem)
        }
        self.valueLabels = items
    }
    
    func stepValueLabelY()->CGFloat{
        return (self.maxValue() - self.minValue()) / CGFloat(self.valueLabelCount - 1)
    }
    
    func allValues()->[Any]?{
        let count = self.dataSource?.numberOfLines()
        var values:[Any] = [Any]()
        for anIndex in 0..<count!{
            let item = self.dataSource?.valueForLine(at: anIndex)
            values = values + item!
        }
        return values
    }

    
    func maxValue()->CGFloat{
        let values = self.allValues()
        if values is [Double] {
            let arrDouble:[Double] = values as! [Double]
            let maxValue = arrDouble.max()
            return CGFloat.init(CGFloat(NSNumber.init(value: maxValue!).floatValue))
        }else if values is [Int]{
            let arrInt:[Int] = values as! [Int]
            return CGFloat(arrInt.max()!)
        }

        return 0.0
    }
    
    
    func minValue()->CGFloat{
        
        if self.startsFromZero{
            return 0.0
        }
        
        let values = self.allValues()
        
        if values is [Double] {
            let arrDouble:[Double] = values as! [Double]
            let minimumValue = arrDouble.min()
            return CGFloat.init(CGFloat(NSNumber.init(value: minimumValue!).floatValue))
        }else if values is [Int]{
            let arrInt:[Int] = values as! [Int]
            return CGFloat(arrInt.min()!)
        }
        
        return 0.0
    }
    
    func constructTitleLabels(){
        let values:[Any]? = self.dataSource?.valueForLine(at: 0)
        var items:[Any] = [Any]()
        
        var index = 0
        if let valueLabels = values {
            for _ in valueLabels {
                let frame  = CGRect.init(x: 0, y: 0, width: defaultLabelWidth, height: defaultLabelHeight)
                let labelItem = UILabel.init(frame: frame)
                labelItem.textAlignment = .center
                labelItem.font = UIFont.boldSystemFont(ofSize: 12.0)
                labelItem.textColor = UIColor.lightGray
                labelItem.text = self.dataSource?.titleForLine(at: index)
                index = index + 1
                items.append(labelItem)
            }
            self.titleLabels = items
        }
    }
    
    func positionTitleLabels(){
        var idx = 0
        let values = self.dataSource?.valueForLine(at: 0)
        
        if let valueLabels = values {
            for _ in valueLabels{
                let labelWidth = defaultLabelWidth
                let labelHeight = defaultLabelHeight
                let startX = self.pointFor(index: idx) - (labelWidth / CGFloat(2.0))
                let startY = self.height() - labelHeight
                if titleLabels.count >= idx{
                    let label:UILabel = self.titleLabels[idx] as! UILabel
                    label.setX(newX: startX)
                    label.setY(newY: startY)
                    self.addSubview(label)
                    idx = idx + 1
                }
               
            }
        }
    }
    
    func stepX()->CGFloat{
        let values = self.dataSource?.valueForLine(at: 0)
        if let valueLabels = values{
            if valueLabels.count > 0{
                return self.plotWidth() / CGFloat(valueLabels.count)
            }
        }
        return 0.0
    }
    
    func plotWidth()->CGFloat{
        return CGFloat(self.width()) - (CGFloat(2 * self.margin) + CGFloat(axisMargin))
    }
    
    func plotHeight() -> CGFloat{
        return CGFloat(self.height()) - (CGFloat(2 * defaultLabelHeight) + CGFloat(defaultMarginBottom))
    }
    

    func pointFor(index:Int)->CGFloat{
        return axisMargin + self.margin + (CGFloat(index) * self.stepX())
    }


    func hasTitleLabels()-> Bool{
        guard self.titleLabels.count > 0 else{
            return false
        }
        return true
    }
    
    func hasValueLabels()->Bool{
        if valueLabels.count > 0 {
            return true
        }else{
            return false
        }
    }
    
    func reset(){
        self.layer.sublayers = nil;
    }
    
    func positionYFor(line value:CGFloat) -> CGFloat{
        let scale = (value - self.minValue()) / (self.maxValue() - self.minValue())
        var result = self.plotHeight() * scale
        result = self.plotHeight() - result
        result = result + defaultLabelHeight
        return result
    }

    func bezierPath(with value:CGFloat)->UIBezierPath{
        let bezierPath = UIBezierPath.init()
        bezierPath.lineCapStyle = .round
        bezierPath.lineJoinStyle = .round
        bezierPath.lineWidth = self.lineWidth
        return bezierPath
    }
    
    func layerWithPath(bezierPath:UIBezierPath)->CAShapeLayer{
        let item = CAShapeLayer.init()
        item.fillColor = UIColor.black.cgColor
        item.lineCap = kCALineCapRound
        item.lineJoin = kCALineJoinRound
        item.lineWidth = self.lineWidth
        item.strokeColor = UIColor.red.cgColor
        item.strokeEnd = 1
        return item
    }
    
    func animationWithKeyPath(keyPath:String)->CABasicAnimation{
    let animation = CABasicAnimation.init(keyPath: keyPath)
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        animation.duration = self.animatedDuration!
        animation.fromValue = 0
        animation.toValue = 1
        return animation
    }
    
    
    func drawLine(at index:Int){
        UIGraphicsBeginImageContext(self.frame.size)
        let bezierPath = self.bezierPath(with: 0)
        let shapeLayer = self.layerWithPath(bezierPath: bezierPath)
        shapeLayer.strokeColor = self.dataSource?.colorForLine(at: index).cgColor
        self.layer.addSublayer(shapeLayer)
        var idx = 0
        let values = self.dataSource?.valueForLine(at: index)
        
        if let items =  values{
            for anItem in items {
                let x = self.positionX(for: idx)
                
                var y:CGFloat = 0.0
                
                if anItem is Int{ //|| anItem is Int8 || anItem is Int16 || anItem is Int32 || anItem is Int32{
                    let x = anItem as! Int
                    y = self.positionYFor(line: CGFloat(x))
                }
                else if anItem is Double{
                    let x = anItem as! Double
                    y = self.positionYFor(line: CGFloat(NSNumber.init(value: x).floatValue))
                }else if anItem is CGFloat{
                    let x = anItem as! CGFloat
                    y = self.positionYFor(line: CGFloat(x))
                }
                
//                else if anItem is Float32 || anItem is Float64 || anItem is Float80{
//                    let x = anItem as! Float80
//                    y = self.positionYFor(line: CGFloat(x))
//                }

                
                let point = CGPoint.init(x: x, y: y)
                
                if idx != 0{
                    bezierPath.addLine(to: point)
                }
                bezierPath.move(to: point)
                bezierPath.miterLimit = -10.0
                idx = idx + 1
            }
            
            shapeLayer.path = bezierPath.cgPath
            
            if self.animated{
                let animation = self.animationWithKeyPath(keyPath: "strokeEnd")
                animation.duration = (self.dataSource?.animateDurationForLine(at: index))!
                shapeLayer.add(animation, forKey: "strokeEndAnimation")
            }
            
            UIGraphicsEndImageContext();
        }
    }
    
    
    func positionX(for index: Int)->CGFloat{
        return axisMargin + self.margin  + (CGFloat(index) * self.stepX())
    }
    
    func drawHorizontalLine(at newY:Any){
        var y:CGFloat
        let bezierPath = UIBezierPath.init()
        if newY is Double {
            y = CGFloat.init(NSNumber.init(value: newY as! Double).floatValue)
        }else if newY is Int{
            y = CGFloat.init(newY as! Int)
        }else {
            y =  newY as! CGFloat
        }
        
        let start = CGPoint.init(x: 40, y: y)
        
        bezierPath.move(to: start)
        bezierPath.addLine(to: CGPoint.init(x: self.x() + self.width(), y: y))
        
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.lineWidth = 1.0
        
        self.layer.addSublayer(shapeLayer)
        
    }
    
}
