//
//  SuffixSequenceViewController.swift
//  DataStructuresProfiling
//
//  Created by Georgy Khaydenko on 17/10/2019.
//  Copyright © 2019 Exey Panteleev. All rights reserved.
//

private enum SuffixArrayVCRow: Int {
  case creation = 0,
  changeSuffixes,
  reverseSuffixArray,
  searchFor10Tripples,
  find10Tripples,
  searchForTripples,
  findTripples

}


import UIKit

class SuffixSequenceViewController: DataStructuresViewController {
      //MARK: - Variables

    var suffixArrayManipulator: SuffixArrayManipulator = SwiftSuffixArrayManipulator()

    var creationTime: TimeInterval = 0
    var changingSuffixesTime: TimeInterval = 0
    var reverseSuffixArrayTime: TimeInterval = 0
    var searchFor10TripplesTime: TimeInterval = 0
    var searchForTripplesTime: TimeInterval = 0

    @IBOutlet weak var trippleLabel: UILabel!
    
    @IBOutlet weak var trippleTextField: UITextField!
    

      //MARK: - Methods

      //MARK: View lifecycle

      override func viewDidLoad() {
        super.viewDidLoad()
        createAndTestButton.setTitle("Create SuffixIterator and Test", for: [])
        trippleLabel.text = "Number of random tripples to test:"
        trippleTextField.delegate = self
        trippleTextField.autocorrectionType = .no
        trippleTextField.keyboardType = .numberPad
      }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func trippleFieldChanged(_ sender: UITextField) {
        guard let text = sender.text, let number = Int(text) else {
            return
        }
        suffixArrayManipulator.numberOfTrippplesToFind = number
    }
    //TODO: при нажатии на тест текстфилд резайн ферст респондер
    //и подумать над отдельным модулем
    
    //MARK: Superclass creation/testing overrides

      override func create(_ size: Int) {
        creationTime = suffixArrayManipulator.setupWithTripplesCount(size)
      }

    override func test() {
        if (suffixArrayManipulator.suffixArrayHasObjects()) {
            changingSuffixesTime = suffixArrayManipulator.changeEachSuffix()
            reverseSuffixArrayTime = suffixArrayManipulator.reverseSuffixArray()
            searchFor10TripplesTime = suffixArrayManipulator.searchFor10Tripples().0
            searchForTripplesTime = suffixArrayManipulator.searchForTripples().0
        } else {
            print("SuffixArray is not set up yet!")
        }
    }

      //MARK: Table View Override


      override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        switch (indexPath as NSIndexPath).row {
        case SuffixArrayVCRow.creation.rawValue:
          cell.textLabel!.text = "SuffixArray Creation:"
          cell.detailTextLabel!.text = formattedTime(creationTime)
        case SuffixArrayVCRow.changeSuffixes.rawValue:
            cell.textLabel!.text = "Changing Each Suffix in Array:"
            cell.detailTextLabel!.text = formattedTime(changingSuffixesTime)
        case SuffixArrayVCRow.reverseSuffixArray.rawValue:
            cell.textLabel!.text = "Reverse SuffixArray:"
            cell.detailTextLabel!.text = formattedTime(reverseSuffixArrayTime)
        case SuffixArrayVCRow.searchFor10Tripples.rawValue:
            cell.textLabel!.text = "Search For 10 Random Tripples:"
            cell.detailTextLabel!.text = formattedTime(searchFor10TripplesTime)
        case SuffixArrayVCRow.find10Tripples.rawValue:
            cell.textLabel!.text = "Find 10 Random Tripples Times:"
            cell.detailTextLabel!.text = String(suffixArrayManipulator.searchFor10Tripples().1)
        case SuffixArrayVCRow.searchForTripples.rawValue:
            cell.textLabel!.text = "Search For Random Tripples:"
            cell.detailTextLabel!.text = formattedTime(searchForTripplesTime)
        case SuffixArrayVCRow.findTripples.rawValue:
            cell.textLabel!.text = "Find Random Tripples Times:"
            cell.detailTextLabel!.text = String(suffixArrayManipulator.searchForTripples().1)
        default:
            print("Unhandled row! \((indexPath as NSIndexPath).row)")
        }
        
        return cell
    }
    
}

extension SuffixSequenceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
