//
//  LineGraphViewController.swift
//  LineGraph
//
//  Created by Saurabh Kumar on 1/24/18.
//  Copyright © 2018 Saurabh Kumar. All rights reserved.
//

import UIKit

class LineGraphViewController: UIViewController,GraphDataSource {
    
    @IBOutlet weak var graph: LineGraph!
    var data:[Any]?
    var labels:[Any]?
    
    func numberOfLines() -> Int {
        return (self.data?.count)!
    }
    
    func colorForLine(at index: Int) -> UIColor {
        let colors = [UIColor.red,UIColor.blue,UIColor.green,UIColor.orange]
        
        return colors[index]
    }
    
    func valueForLine(at index: Int) -> [Any]? {
        return self.data?[index] as? [Any]
    }
    
    func animateDurationForLine(at index: Int) -> CFTimeInterval {
        return 1.0
    }
    
    func titleForLine(at index: Int) -> String? {
        return self.labels?[index] as? String
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupExampleGraph()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupExampleGraph(){
        self.data = [
        [20, 40, 20, 60, 40, 140, 80],
        [40, 20, 60, 100, 60, 20, 60],
        [80, 60, 40, 160, 100, 40, 110],
        [120, 150, 80, 120, 140, 100, 0],
        ]
        self.labels = ["2015","2016","2017","2018","2019","2020","2021"]
        self.graph.dataSource = self
        self.graph.lineWidth = 3.0
        self.graph.valueLabelCount = 6
        self.graph.draw()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
