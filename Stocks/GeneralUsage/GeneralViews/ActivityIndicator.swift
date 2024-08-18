//
//  ActivityIndicator.swift
//  Stocks
//
//  Created by Hasan Aygünoglu on 18.08.2024.
//

import UIKit

final class ActivityIndicator {
  private var backgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var loadingView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    view.widthAnchor.constraint(equalToConstant: 180).isActive = true
    view.heightAnchor.constraint(equalToConstant: 110).isActive = true
    view.layer.cornerRadius = 10
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private var spinner: UIActivityIndicatorView = {
    let spinner = UIActivityIndicatorView(style: .large)
    spinner.tintColor = .label
    spinner.translatesAutoresizingMaskIntoConstraints = false
    return spinner
  }()
  
  private var loadingLabel: UILabel = {
    let label = UILabel()
    label.text = "Loading..."
    label.textColor = .label
    label.font = .systemFont(ofSize: 22, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  public func initialize(in superView: UIView) {
    superView.addSubview(backgroundView)
    setConstraints(with: superView)
  }
  
  public func shouldAnimate(_ shouldAnimate: Bool) {
    if shouldAnimate {
      backgroundView.isHidden = false
      spinner.startAnimating()
      backgroundView.superview?.bringSubviewToFront(backgroundView)
      backgroundView.bringSubviewToFront(loadingView)
    } else {
      backgroundView.isHidden = true
      spinner.stopAnimating()
    }
  }
  
  private func setConstraints(with superView: UIView) {
    backgroundView.addSubview(loadingView)
    loadingView.addSubview(spinner)
    loadingView.addSubview(loadingLabel)
    
    backgroundView.widthAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.widthAnchor).isActive = true
    backgroundView.heightAnchor.constraint(equalTo: superView.heightAnchor).isActive = true
    backgroundView.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
    backgroundView.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    
    loadingView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
    loadingView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor).isActive = true
    spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
    spinner.topAnchor.constraint(equalTo: loadingView.topAnchor, constant: 16).isActive = true
    loadingLabel.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
    loadingLabel.bottomAnchor.constraint(equalTo: loadingView.bottomAnchor, constant: -16).isActive = true
  }
}
