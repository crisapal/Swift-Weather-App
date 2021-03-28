
import UIKit

class ViewController: UIViewController {
    
    var day:String=""
    var location:String=""
    var temperature:String=""
    var weatherMood:String=""
    var weatherPic:UIImage?=nil
    
    @IBOutlet var EarthImage: UIImageView!
    
    @IBOutlet var LocationArea: UITextField!
    
    @IBAction func SendLocation(_ sender: UIButton) {
        
        let locationText:String? = LocationArea.text
        
        
        if locationText?.count == 0{
            alertMessage()
        }
        else{
            
            let locationLocal = locationText!.replacingOccurrences(of: " ", with: "+")

            
            guard let url = URL(string:"http://api.openweathermap.org/data/2.5/forecast?q=\(locationLocal)&APPID=142293ee2dbbf28425a3d7d05a8f4b75") else { print("SOMETHING GOES WRONG IN YOUR URL")
                return }
            
            let task = URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data, error == nil{
                    do{
                        guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                        
            
                        if "\(json["cod"] ?? "404")" == String(404) {
                            DispatchQueue.main.async {
                                self.alertMessage()
                            }
                        }
                    else{
                    
                    
                    
                            
                    guard let detailsWeather = json["list"] as? [[String:Any]] else {return}
                    
                    guard let detailsWeatherWeather = detailsWeather[0]["weather"] as? [[String:Any]] else {return}
                    
                    guard let detailsWeatherMain = detailsWeather[0]["main"] as? [String:Any] else {return}
                            
            
                self.location = locationText ?? "Eroare"
                            
                            self.day = self.getDate()
                self.weatherMood = "\(detailsWeatherWeather[0]["description"]!)".capitalized
                            
                    guard let localTemperature =  detailsWeatherMain["temp"] as? Double else { return }
                    
                            self.temperature = String(format: "%.1f", localTemperature - 273.15)

                         
                            if self.weatherMood.uppercased().contains("SUN") || self.weatherMood.uppercased().contains("CLEAR"){
                                self.weatherPic = UIImage(named: "01d.png")
                                
                            }
                            else if self.weatherMood.uppercased().contains(" SHOWER RAIN") || self.weatherMood.uppercased().contains("DRIZZLE") {
                                   self.weatherPic = UIImage(named: "09d.png")
                            }else if self.weatherMood.uppercased().contains("RAIN"){
                                 self.weatherPic = UIImage(named: "10d.png")
                            }
                            else if self.weatherMood.uppercased().contains("SNOW"){
                                 self.weatherPic = UIImage(named: "13d.png")
                            }
                            else if self.weatherMood.uppercased().contains("STORM"){
                                 self.weatherPic = UIImage(named: "11d.png")
                            }
                            else if self.weatherMood.uppercased().contains("FEW CLOUDS")
                            {
                                  self.weatherPic = UIImage(named: "02d.png")
                            }
                            else{ // pun clouds
                                  self.weatherPic = UIImage(named: "03d.png")
                            }
                            
                            
                    DispatchQueue.main.async {
                                 
                    self.performSegue(withIdentifier: "SecondViewConnection", sender: self)
                    }
                }
                    } catch{
                        print("Some error")
                    }
               
                }
            }
            
            task.resume()

            
           
        }
        
    }
    
    func alertMessage(){
        let alertMessage = UIAlertController( title: "WRONG INPUT", message: "Please type a valid location" , preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title:"Try again",style: .default,handler:.none))
        present(alertMessage,animated: true)

        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! WeatherController
        vc.day = day
        vc.location = location
        vc.temperature = temperature
        vc.weatherMood = weatherMood
        vc.weatherPicVar = weatherPic
    }
    
    func getDate()->String{
        let now = Date()

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none

        let datetime = formatter.string(from: now)
        return "\(datetime)"
        // Wednesday, March 11, 2020 at 3:25:11 PM Central European Standard Time
    }
    
    
    
    
}


