//
//  ABViewController.swift
//  NumberGames
//
//  Created by 王宜婕 on 2024/11/2.
//

import UIKit

class ABViewController: UIViewController {
    
    @IBOutlet var NumButtons: [UIButton]!
    @IBOutlet var GueLabels: [UILabel]!
    @IBOutlet weak var ResultTextField: UITextView!
    @IBOutlet weak var EnButton: UIButton!
    @IBOutlet weak var BaButton: UIButton!
    @IBOutlet weak var ReButton: UIButton!
    @IBOutlet var NorButtons: [UIButton]!
    
    @IBOutlet weak var GiveUpButton: UIButton!
    var countAB:Int = 0
    var ansNumAB:Int = 0
    var NumbersAB = ["0","1","2","3","4","5","6","7","8","9"]
    var AnswersAB:[String] = []
    var GuessAB:[String] = ["","","",""]
    var AnumAB:Int = 0
    var BnumAB:Int = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ResetAB()
        startAB()
        updateUIAB()

        // Do any additional setup after loading the view.
    }
    func updateUIAB(){
        for i in 0..<GuessAB.count{
            GueLabels[i].text = GuessAB[i]
        }
    }
    func startAB(){
        let Startcontroller = UIAlertController(title: "1A2B遊戲開始！", message: "", preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "好！", style: .default)
        Startcontroller.addAction(YesAction)
        present(Startcontroller, animated: true)
        BaButton.isEnabled = false
        EnButton.isEnabled = false
        for i in 0..<NorButtons.count{
            NorButtons[i].tintColor = .systemBlue
        }
        for _ in 0..<4{
            let randomNumAB = Int.random(in: 0..<NumbersAB.count)
            AnswersAB.append(NumbersAB[randomNumAB])
            NumbersAB.remove(at: randomNumAB)
        }
        ReButton.isEnabled = false
        print(AnswersAB)
        ResultTextField.text = ""
    }
    
    func retryAB(){
        ResetAB()
        countAB = 0
        AnswersAB.removeAll()
        NumbersAB = ["0","1","2","3","4","5","6","7","8","9"]
        startAB()
    }
    
    func ResetAB(){
        GuessAB = ["","","",""]
        updateUIAB()
        ansNumAB = 0
        AnumAB = 0
        BnumAB = 0
        for index in 0..<NumButtons.count{
            NumButtons[index].isEnabled = true
        }
    }
    
    
    
    
    
    @IBAction func NumberTapped(_ sender: UIButton) {
        ReButton.isEnabled = true
        sender.isEnabled = false
        GuessAB[ansNumAB] = String(sender.tag)
        updateUIAB()
        if ansNumAB == 3 {
            for index in 0..<NumButtons.count{
                NumButtons[index].isEnabled = false
            }
            EnButton.isEnabled = true
            
        }else{
            BaButton.isEnabled = true
        }
        ansNumAB += 1
        
    }
    
    
    @IBAction func ResetTapped(_ sender: Any) {
        ReButton.isEnabled = false
        for index in 0..<NumButtons.count{
            NumButtons[index].isEnabled = true
        }
        ResetAB()
    }
    
    
    @IBAction func EnterTapped(_ sender: Any) {
        BaButton.isEnabled = false
        EnButton.isEnabled = false
        ReButton.isEnabled = false
        for index in 0..<NumButtons.count{
            NumButtons[index].isEnabled = true
        }
        for num in 0..<4{
            if GuessAB[num] == AnswersAB[num]{
                AnumAB += 1
            }else if GuessAB.contains(AnswersAB[num]){
                BnumAB += 1
            }
        }
        countAB += 1
        //創造一個包含輸入的數字跟結果的常數字串，加入\n換行
        let resultMessage = "\(GueLabels[0].text!) \(GueLabels[1].text!) \(GueLabels[2].text!) \(GueLabels[3].text!)                  \(AnumAB) A \(BnumAB) B\n"
        //把常數字串顯示在Text View上，用+=使字串可以一直加上去
        ResultTextField.text += resultMessage
        if GuessAB == AnswersAB {
            let OKcontroller = UIAlertController(title: "恭喜過關！", message: "一共猜了\(countAB)次", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "好！", style: .default)
            let tryAction = UIAlertAction(title: "再試一次！", style: .default){
                tryAction in
                self.retryAB()
            }
            OKcontroller.addAction(okAction)
            OKcontroller.addAction(tryAction)
            present(OKcontroller, animated: true)
        }else{
            ResetAB()
        }
    }
    
    @IBAction func BackTapped(_ sender: UIButton) {
        NumButtons[Int(GuessAB[ansNumAB-1])!].isEnabled = true
        if ansNumAB == 4{
            for index in 0..<NumButtons.count{
                NumButtons[index].isEnabled = true
            }
            for i in 1..<4{
                NumButtons[Int(GuessAB[i-1])!].isEnabled = false
            }
        }
        GuessAB[ansNumAB-1] = ""
        ansNumAB -= 1
        if ansNumAB == 0{
            sender.isEnabled = false
            ReButton.isEnabled = false
            for index in 0..<NumButtons.count{
                NumButtons[index].isEnabled = true
            }
            ResetAB()
        }else{
            sender.isEnabled = true
        }
        updateUIAB()
        EnButton.isEnabled = false
    }
    
    @IBAction func NorTapped(_ sender: UIButton) {
        if sender.tintColor == .green{
            sender.tintColor = .systemBlue
        }else if sender.tintColor == .red{
            sender.tintColor = .green
        }else{
            sender.tintColor = .red
        }
    }
    
    @IBAction func GiveUpTapped(_ sender: Any) {
        var AnsLabelAB = ""
        for i in 0..<AnswersAB.count{
            AnsLabelAB.append("\(AnswersAB[i])")
        }
        let Endcontroller = UIAlertController(title: "再試一次吧！", message: "正確答案是\(AnsLabelAB)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好！", style: .default){
            okAction in
            self.retryAB()
        }
        Endcontroller.addAction(okAction)
        present(Endcontroller, animated: true)
    }
    
}
#Preview{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //withIdentifier內打入View名稱
    return storyboard.instantiateViewController(withIdentifier: "ABViewController")
}

