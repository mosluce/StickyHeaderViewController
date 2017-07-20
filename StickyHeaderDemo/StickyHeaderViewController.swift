//
//  StickyHeaderViewController.swift
//  StickyHeaderDemo
//
//  Created by 默司 on 2017/7/20.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class StickyHeaderViewController: UIViewController {

    fileprivate var scrollOffset: CGPoint = .zero
    fileprivate var scrollView: UIScrollView?
    fileprivate var currentConstant: CGFloat = 0
    
    @IBOutlet var headerOffsetConstrant: NSLayoutConstraint? {
        didSet {
            self.currentConstant = headerOffsetConstrant?.constant ?? 0
        }
    }
    
    @IBInspectable var headerMinOffset: CGFloat = 0
    @IBInspectable var headerMaxOffset: CGFloat = 200
    
    @IBInspectable var delayBuffer: CGFloat = 50
    @IBInspectable var delayPool: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeScrollableView(_ scrollView: UIScrollView) {
        if let sc = self.scrollView {
            sc.removeObserver(self, forKeyPath: "contentOffset")
        }
        
        self.scrollOffset = scrollView.contentOffset
        self.scrollView = scrollView
        
        scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let constraint = headerOffsetConstrant else {
            return
        }
        
        guard let sc = self.scrollView,
            let keyPath = keyPath,
            let offset = sc.value(forKey: keyPath) as? CGPoint else {
            return
        }
        
        let move = offset.y - scrollOffset.y
        
        var constant = currentConstant - move
        
        if constant > headerMaxOffset {
            constant = headerMaxOffset
        }
        
        if constant < headerMinOffset {
            constant = headerMinOffset
        }

        print(constant)
        
        constraint.constant = constant
        
        UIView.animate(withDuration: 0.15) {[weak self] () in
            self?.view.layoutIfNeeded()
        }
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
}
