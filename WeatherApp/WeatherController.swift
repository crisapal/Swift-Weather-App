

import UIKit

class WeatherController: UIViewController {

    var day = ""
    var location = ""
    var weatherPicVar: UIImage?
    var weatherMood = ""
    var temperature = ""
    
    @IBOutlet var DayOfLabel: UILabel!
    
    @IBOutlet var LocationLabel: UILabel!
    
    @IBOutlet var WeatherPic: UIImageView!
    
    @IBOutlet var WeatherMood: UILabel!
    
    @IBOutlet var TemperatureLabel: UILabel!
    
    override func viewDidLoad(){
    
        super.viewDidLoad()
        DayOfLabel.text = day
        LocationLabel.text = location
        WeatherPic.image = weatherPicVar
        TemperatureLabel.text = temperature
        WeatherMood.text = weatherMood
        
    }
    

}
