//
//  UITableView+Ex.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

extension UITableView {
    func highlightRows(
        for indexPaths: [IndexPath],
        background color: UIColor = .systemYellow,
        _ alpha: CGFloat = 0.2
    ) {
        indexPaths.forEach { indexPath in
            let targetRect = self.rectForRow(at: indexPath)
            let view = UIView(frame: targetRect)
            view.alpha = alpha
            view.backgroundColor = color
            view.isUserInteractionEnabled = false
            self.addSubview(view)
            
            UIView.animate(withDuration: 0.75, animations: { view.alpha = 0 }) { end in
                if end {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
