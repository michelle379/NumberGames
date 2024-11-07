//
//  GuessNumberViewController.swift
//  NumberGames
//
//  Created by 王宜婕 on 2024/11/2.
//

import UIKit

class GuessNumberViewController: UIViewController {

    @IBOutlet weak var GameOverImage: UIImageView!
    @IBOutlet weak var GameOverLabel: UILabel!
    @IBOutlet weak var GuessButton: UIButton!
    @IBOutlet weak var GameOverView: UIView!
    @IBOutlet weak var LifeLabel: UILabel!
    @IBOutlet weak var GuessText: UITextField!
    @IBOutlet weak var ScopeLabel: UILabel!
    var life = 6
    var GuessAnswer: Int = Int.random(in: 1...99)
    var max: Int = 100
    var min: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(GuessAnswer)
        updateUI()
        GuessButton.isEnabled = true
        GameOverView.isHidden = true
        // Do any additional setup after loading the view.
    }
    //收鍵盤
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
    func updateUI(){
        GuessText.text = ""
        ScopeLabel.text = "\(min)~\(max)"
        LifeLabel.text = "\(life)"
    }
    func retry(){
        min = 0
        max = 100
        life = 6
        GuessAnswer = Int.random(in: 1...99)
        updateUI()
    }
    
    @IBAction func ButtonTapped(_ sender: Any) {
        if let Guess = Int(GuessText.text!) , Guess > min && Guess < max{
            life -= 1
            if Guess == GuessAnswer{
                GameOverView.isHidden = false
                GuessButton.isEnabled = false
                GameOverImage.image = UIImage(named: "win")
                GameOverLabel.text = "恭喜過關！！"
            }else if life == 0{
                GameOverView.isHidden = false
                GuessButton.isEnabled = false
                GameOverImage.image = UIImage(named: "lose")
                GameOverLabel.text = "Game Over!! 正確答案是\(GuessAnswer)"
            }
            else{
                if GuessAnswer < Guess{
                    max = Guess
                }else{
                    min = Guess
                }
            }

        }else{
            let controller = UIAlertController(title: "輸入錯誤！", message: "請輸入\(min)~\(max)的數字", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            controller.addAction(okAction)
            present(controller, animated: true)
        }
        updateUI()
    }



    @IBAction func OKButton(_ sender: Any) {
        GameOverView.isHidden = true
    }
    @IBAction func RetryButton(_ sender: Any) {
        GuessButton.isEnabled = true
        GameOverView.isHidden = true
        retry()
    }
}
#Preview{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //withIdentifier內打入View名稱
    return storyboard.instantiateViewController(withIdentifier: "GuessNumberViewController")
}

