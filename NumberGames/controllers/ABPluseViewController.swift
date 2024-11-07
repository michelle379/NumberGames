//
//  ABPluseViewController.swift
//  NumberGames
//
//  Created by 王宜婕 on 2024/11/2.
//

import UIKit

class ABPluseViewController: UIViewController {
    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet var NormalButtons: [UIButton]!
    @IBOutlet weak var EnterButton: UIButton!
    @IBOutlet var NumberButtons: [UIButton]!
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet var AnswerLabels: [UILabel]!
    
    @IBOutlet var ResultLabels: [UILabel]!
    
    @IBOutlet var GuessLabels: [UILabel]!
    var count:Int = 0
    var ansNum:Int = 0
    var Numbers = ["0","1","2","3","4","5","6","7","8","9"]
    var Answers:[String] = []
    var Guess:[String] = ["","","",""]
    var Anum:Int = 0
    var Bnum:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Reset()
        start()
        updateUI()
        // Do any additional setup after loading the view.
    }
    func updateUI(){
        for i in 0..<Guess.count{
            GuessLabels[i].text = Guess[i]
        }
    }
    func start(){
        let Startcontroller = UIAlertController(title: "在6次內猜對答案吧！", message: "", preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "好！", style: .default)
        Startcontroller.addAction(YesAction)
        present(Startcontroller, animated: true)
        for k in 0..<ResultLabels.count{
            ResultLabels[k].text = ""
            ResultLabels[k].textColor = .black
        }
        BackButton.isEnabled = false
        EnterButton.isEnabled = false
        for j in 0..<AnswerLabels.count{
            AnswerLabels[j].text = ""
            AnswerLabels[j].textColor = .black
        }
        for i in 0..<NormalButtons.count{
            NormalButtons[i].tintColor = .systemBlue
        }
        for _ in 0..<4{
            let randomNum = Int.random(in: 0..<Numbers.count)
            Answers.append(Numbers[randomNum])
            Numbers.remove(at: randomNum)
        }
        ResetButton.isEnabled = false
        print(Answers)
    }
    
    func retry(){
        Reset()
        count = 0
        Answers.removeAll()
        Numbers = ["0","1","2","3","4","5","6","7","8","9"]
        start()
    }
    
    func Reset(){
        Guess = ["","","",""]
        updateUI()
        ansNum = 0
        Anum = 0
        Bnum = 0
        for index in 0..<NumberButtons.count{
            NumberButtons[index].isEnabled = true
        }
    }


    @IBAction func NormalButton(_ sender: UIButton) {
        
        if sender.tintColor == .green{
            sender.tintColor = .systemBlue
        }else if sender.tintColor == .red{
            sender.tintColor = .green
        }else{
            sender.tintColor = .red
        }
        
    }
    
    @IBAction func BackButton(_ sender: UIButton) {
        NumberButtons[Int(Guess[ansNum-1])!].isEnabled = true
        if ansNum == 4{
            for index in 0..<NumberButtons.count{
                NumberButtons[index].isEnabled = true
            }
            for i in 1..<4{
                NumberButtons[Int(Guess[i-1])!].isEnabled = false
            }
        }
        Guess[ansNum-1] = ""
        ansNum -= 1
        if ansNum == 0{
            sender.isEnabled = false
            ResetButton.isEnabled = false
            for index in 0..<NumberButtons.count{
                NumberButtons[index].isEnabled = true
            }
            Reset()
        }else{
            sender.isEnabled = true
        }
        updateUI()
        EnterButton.isEnabled = false
    }
    
    
    fileprivate func GameEnd() {
        var AnsLabel = ""
        for i in 0..<Answers.count{
            AnsLabel.append("\(Answers[i])")
        }
        let Endcontroller = UIAlertController(title: "再試一次吧！", message: "正確答案是\(AnsLabel)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好！", style: .default){
            okAction in
            self.retry()
        }
        Endcontroller.addAction(okAction)
        present(Endcontroller, animated: true)
    }
    
    @IBAction func EnterButton(_ sender: Any) {
        BackButton.isEnabled = false
        EnterButton.isEnabled = false
        ResetButton.isEnabled = false
        if Guess == Answers {
            AnswerLabels[count].text = Guess.joined()
            AnswerLabels[count].textColor = .red
            ResultLabels[count].text = "4A0B"
            ResultLabels[count].textColor = .red
            let OKcontroller = UIAlertController(title: "恭喜過關！", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好！", style: .default)
            let tryAction = UIAlertAction(title: "再試一次！", style: .default){
                tryAction in
                self.retry()
            }
            OKcontroller.addAction(okAction)
            OKcontroller.addAction(tryAction)
            present(OKcontroller, animated: true)
        }else{
            if count == 5{
                AnswerLabels[count].text = Guess.joined()
                ResultLabels[count].text = "\(Anum)A\(Bnum)B"
                GameEnd()
            }else{
                for index in 0..<NumberButtons.count{
                    NumberButtons[index].isEnabled = true
                }
                for num in 0..<4{
                    if Guess[num] == Answers[num]{
                        Anum += 1
                    }else if Guess.contains(Answers[num]){
                        Bnum += 1
                    }
                }
                AnswerLabels[count].text = Guess.joined()
                ResultLabels[count].text = "\(Anum)A\(Bnum)B"
                count += 1
                Reset()
            }
        }

    }
    
    @IBAction func ResetButton(_ sender: Any) {
        ResetButton.isEnabled = false
        for index in 0..<NumberButtons.count{
            NumberButtons[index].isEnabled = true
        }
        Reset()
    }
    
    
    @IBAction func NumberButton(_ sender: UIButton) {
        ResetButton.isEnabled = true
        sender.isEnabled = false
        Guess[ansNum] = String(sender.tag)
        updateUI()
        if ansNum == 3 {
            for index in 0..<NumberButtons.count{
                NumberButtons[index].isEnabled = false
            }
            EnterButton.isEnabled = true
            
        }else{
            BackButton.isEnabled = true
        }
        ansNum += 1
    }
    
    
    @IBAction func Retry(_ sender: Any) {
        GameEnd()
        
    }
    
}

#Preview{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //withIdentifier內打入View名稱
    return storyboard.instantiateViewController(withIdentifier: "ABPluseViewController")
}

