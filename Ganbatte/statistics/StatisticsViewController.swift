//
//  StatisticsViewController.swift
//  Ganbatte
//
//  Created by Student on 18/09/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController, ChartViewDelegate {

    @IBOutlet var radarChartView: RadarChartView!
    
    let emotions = ["☹️", "😐", "🙂"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        radarChartView.delegate = self
        setChartData()
        
        radarChartView.chartDescription?.enabled = false
        radarChartView.webLineWidth = 1
        radarChartView.innerWebLineWidth = 1
        radarChartView.webColor = .lightGray
        radarChartView.innerWebColor = .lightGray
        radarChartView.webAlpha = 1
        
        let xAxis = radarChartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 38, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        xAxis.labelTextColor = .white
        
        let yAxis = radarChartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 20, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false
        
        let l = radarChartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .top
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 10, weight: .light)
        l.xEntrySpace = 7
        l.yEntrySpace = 5
        l.textColor = .white
        
        
        
        radarChartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4, easingOption: .easeOutBack)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setChartData() {
        let mult: UInt32 = 80
        let min: UInt32 = 20
        let cnt = 3
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        let entries2 = (0..<cnt).map(block)
        let entries3 = (0..<cnt).map(block)
        
        let set1 = RadarChartDataSet(entries: entries1, label: "Accomplishment")
        set1.setColor(UIColor(red: 242/255, green: 92/255, blue: 5/255, alpha: 1))
        set1.fillColor = UIColor(red: 242/255, green: 92/255, blue: 5/255, alpha: 0.5)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = true
        set1.setDrawHighlightIndicators(false)
        
        let set2 = RadarChartDataSet(entries: entries2, label: "Concentration")
        set2.setColor(UIColor(red: 29/255, green: 26/255, blue: 235/255, alpha: 1))
        set2.fillColor = UIColor(red: 29/255, green: 26/255, blue: 235/255, alpha: 0.5)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.7
        set2.lineWidth = 2
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        
        let set3 = RadarChartDataSet(entries: entries3, label: "Productivity")
        set3.setColor(UIColor(red: 255/255, green: 12/255, blue: 113/255, alpha: 1))
        set3.fillColor = UIColor(red: 255/255, green: 12/255, blue: 113/255, alpha: 0.5)
        set3.drawFilledEnabled = true
        set3.fillAlpha = 0.7
        set3.lineWidth = 2
        set3.drawHighlightCircleEnabled = true
        set3.setDrawHighlightIndicators(false)
        
        let data = RadarChartData(dataSets: [set1, set2, set3])
        data.setValueFont(.systemFont(ofSize: 12, weight: .light))
        data.setDrawValues(true)
        data.setValueTextColor(.white)
        
        radarChartView.data = data
    }

}

extension StatisticsViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return emotions[Int(value) % emotions.count]
    }
}
