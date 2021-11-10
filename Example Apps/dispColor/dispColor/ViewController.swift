import UIKit
import GameplayKit

class ViewController: UIViewController {
    @IBOutlet weak var colorLabel: UILabel!
    let randomSource = GKARC4RandomSource()
    var colorR = 0
    var colorG = 0
    var colorB = 0
    
    override func viewWillAppear(_ animated: Bool) {
        colorR = randomSource.nextInt(upperBound: 256)
        colorG = randomSource.nextInt(upperBound: 256)
        colorB = randomSource.nextInt(upperBound: 256)
        colorLabel.text = "R: \(colorR)   G: \(colorG)   B: \(colorB)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextvc = segue.destination as! ColorViewController
        nextvc.colorR = colorR
        nextvc.colorG = colorG
        nextvc.colorB = colorB
    }
    
    @IBAction func returnTop(segue: UIStoryboardSegue) {
        colorR = randomSource.nextInt(upperBound: 256)
        colorG = randomSource.nextInt(upperBound: 256)
        colorB = randomSource.nextInt(upperBound: 256)
        colorLabel.text = "R: \(colorR)   G: \(colorG)   B: \(colorB)"
    }
    
}

