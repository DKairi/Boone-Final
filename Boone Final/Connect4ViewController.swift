//
//  Connect4ViewController.swift
//  Boone Final
//
//  Created by d.boone on 4/28/23.
//

import UIKit

class Connect4ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    
    
    

    @IBOutlet var CollectionView: UICollectionView!
   
    @IBOutlet var turnImage: UIImageView!
    
    var redScore = 0
    var yellowScore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetBoard()
        setCellWidthHeight()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func setCellWidthHeight(){
        let width = CollectionView.frame.size.width / 9
                let height = CollectionView.frame.size.height / 6
                let flowLayout = CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
                flowLayout.itemSize = CGSize(width: width, height: height)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.count
    }
    func CollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! BoardCell
                
                let boardItem = getBoardItem(indexPath)
                cell.image.tintColor = boardItem.tileColor()
                return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItem(column){
            if let cell = CollectionView.cellForItem(at: boardItem.indexPath) as? BoardCell{
                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
                
                if victoryAchieved(){
                    if yellowTurn()
                                        {
                                            yellowScore += 1
                                        }
                                        
                                        if redTurn()
                                        {
                                            redScore += 1
                                        }
                                        resultAlert(currentTurnVictoryMessage())
                }
                
                if boardIsFull(){
                    resultAlert("Draw")
                }
                
                toggleTurn(turnImage)
            }
        }
    }
    
    func resultAlert(_ title: String){
        let message = "\nRed: " + String(redScore) + "\n\nYellow: " + String(yellowScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {[self] (_) in
            resetBoard()
            self.resetCells()
            
        }))
        self.present(ac, animated:true)
    }
    
    func resetCells() {
        for cell in CollectionView.visibleCells as! [BoardCell]{
            cell.image.tintColor = .white
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
