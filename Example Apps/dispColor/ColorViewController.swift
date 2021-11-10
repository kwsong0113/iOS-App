import UIKit

class ColorViewController: UIViewController {
    
    var colorR = 0
    var colorG = 0
    var colorB = 0
    
    override func viewWillAppear(_ animated: Bool) {
        let backColor = UIColor(
            red: CGFloat(colorR) / 256.0,
            green: CGFloat(colorG) / 256.0,
            blue: CGFloat(colorB) / 256.0,
            alpha: 1.0
        )
        view.backgroundColor = backColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}
