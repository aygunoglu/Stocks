//
//  StocksHeaderView.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

protocol StocksHeaderViewDelegate: AnyObject {
    func primaryFieldDidChange(to field: Field)
    func secondaryFieldDidChange(to field: Field)
}

final class StocksHeaderView: UIView {
    @IBOutlet private weak var primaryFieldButton: UIButton!
    @IBOutlet private weak var secondaryFieldButton: UIButton!
    
    weak var delegate: StocksHeaderViewDelegate?
    
    // MARK: - Initiliazation
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.fromNib()
    }
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      self.fromNib()
    }
    
    func configureButtons(
        fields: [Field],
        selectedPrimaryField: Field? = nil,
        selectedSecondaryField: Field? = nil
    ) {
        primaryFieldButton.setTitle(selectedPrimaryField?.name ?? "Kriter", for: .normal)
        secondaryFieldButton.setTitle(selectedSecondaryField?.name ?? "Kriter", for: .normal)
        
        var primaryFieldActions: [UIAction] = []
        var secondaryFieldActions: [UIAction] = []
        
        fields.forEach { field in
            let primaryAction = UIAction(title: field.name ?? "") { action in
                self.primaryFieldButton.setTitle(field.name, for: .normal)
                self.delegate?.primaryFieldDidChange(to: field)
            }
            
            let secondaryAction = UIAction(title: field.name ?? "") { action in
                self.secondaryFieldButton.setTitle(field.name, for: .normal)
                self.delegate?.secondaryFieldDidChange(to: field)
            }
            
            primaryFieldActions.append(primaryAction)
            secondaryFieldActions.append(secondaryAction)
        }
        
        primaryFieldButton.menu = UIMenu(title: "Kriter Seçiniz", children: primaryFieldActions)
        secondaryFieldButton.menu = UIMenu(title: "Kriter Seçiniz", children: secondaryFieldActions)
    }
}
