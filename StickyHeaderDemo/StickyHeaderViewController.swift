//
//  StickyHeaderViewController.swift
//  StickyHeaderDemo
//
//  Created by 默司 on 2017/7/20.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class StickyHeaderViewController: UIViewController {

    fileprivate var currentScrollOffset: CGPoint = .zero
    
    @IBOutlet var headerOffsetConstrant: NSLayoutConstraint?
    @IBOutlet var scrollView: UIScrollView? {
        didSet {
            oldValue?.removeObserver(self, forKeyPath: "contentOffset")
            
            scrollView?.setContentOffset(.zero, animated: false)
            scrollView?.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            
            UIView.animate(withDuration: 0.2) {
                self.headerOffsetConstrant?.constant = self.headerMaxOffset
                self.view.layoutIfNeeded()
            }
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let scrollView = object as? UIScrollView, keyPath == "contentOffset" {
            self.contentOffsetDidUpdate(scrollView.contentOffset)
        }
    }
    
    deinit {
        self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    private func contentOffsetDidUpdate(_ contentOffset: CGPoint) {
        guard let constraint = headerOffsetConstrant, let scrollView = self.scrollView else {
            return
        }
        
        let o = scrollView.contentOffset.y
        let h = scrollView.frame.height
        let c = scrollView.contentSize.height
        
        guard scrollView.isDragging, o > 0, o + h <= c else {
            return
        }
        
        let move = contentOffset.y - currentScrollOffset.y
        
        self.currentScrollOffset = contentOffset
        
        var constant = constraint.constant - move

        if constant > headerMaxOffset { constant = headerMaxOffset }
        else if constant < headerMinOffset { constant = headerMinOffset }

        constraint.constant = constant
        
        UIView.animate(withDuration: 0.15) { 
            self.view.layoutIfNeeded()
        }
    }
}
