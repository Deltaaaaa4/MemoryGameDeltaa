//
//  ViewController.swift
//  MemoryGame2
//
//  Created by Yerlan Tleubayev on 29.06.2023.
//

import UIKit

class ViewController: UIViewController {
    var images = ["naruto","sasuke","itachi","deidara","gaara","neji","kimimaro","sasori","naruto","sasuke","itachi","deidara","gaara","neji","kimimaro","sasori"]
    var winState = [[0,8],[1,9],[2,10],[3,11],[4,12],[5,13],[6,14],[7,15]]
    var state = [Int](repeating: 0, count: 16)
    var isfreeze = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearGame()
    }
    
    @IBAction func game(_ sender: UIButton) {
        if state [sender.tag - 1] != 0 || isfreeze{
            return
        }
        state[sender.tag - 1] = 1
        
        
        sender.setBackgroundImage(UIImage(named: images[sender.tag - 1]), for: .normal)
        
        
        var count = 0
        for item in state{
            if item == 1{
                count += 1
            }
        }
        if count == 2{
            isfreeze = true
            for winArray in winState{
                if state[winArray[0]] == state[winArray[1]] && state[winArray[0]] == 1{
                    state[winArray[0]] = 2
                    state[winArray[1]] = 2
                    isfreeze = false
                }
            }
            if isfreeze{
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(clear), userInfo: nil, repeats: false)
            }
        }
        if !state.contains(0){
            let alert = UIAlertController(title: "You won!", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok!",style: .default,handler: { UIAlertAction in self.clearGame()
                
            }))
            present(alert,animated: true,completion: nil)
        }
    }
    @objc func clear(){
        isfreeze = false
        for i in 0 ... 15{
            if state[i] == 1{
                state[i] = 0
                let button = view.viewWithTag(i+1) as! UIButton
                button.setBackgroundImage(nil, for: .normal)
                
            }
        }
    }
    
    func clearGame(){
        isfreeze = false
        for i in 0 ... 15{
            state[i] = 0
            let button = view.viewWithTag(i+1) as! UIButton
            button.setBackgroundImage(nil, for: .normal)
        }
        images.shuffle()
        winState.removeAll()
        for i in 0...15{
            for j in 0...15{
                if images[i] == images[j] && i != j {
                    winState.append([i,j])
                    break
                }
            }
        }
    }
    
}



