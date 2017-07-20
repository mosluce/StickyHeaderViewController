//
//  ViewController.swift
//  StickyHeaderDemo
//
//  Created by 默司 on 2017/7/20.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class ViewController: StickyHeaderViewController {
    
    lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return view
    }()
    
    lazy var pager: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        return vc
    }()
    
    lazy var pages: [NumbersTableViewController] = {
        return [NumbersTableViewController(count: 5), NumbersTableViewController(count: 20)]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.addChildViewController(pager)
        
        self.pager.didMove(toParentViewController: self)
        self.pager.delegate = self
        self.pager.dataSource = self
        self.pager.setViewControllers([pages[0]], direction: .forward, animated: false)
        
        self.changeScrollableView(pages[0].tableView)
        
        self.setupLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func setupLayout() {
        self.view.addSubview(pager.view)
        self.view.addSubview(topView)
        self.view.addSubview(headerView)
        
        self.pager.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        self.headerOffsetConstrant = self.topView.heightAnchor.constraint(equalToConstant: headerMaxOffset)
        self.headerOffsetConstrant?.isActive = true

        self.headerView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        self.headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        self.pager.view.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        self.pager.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.pager.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.pager.view.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
}

extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController == pages.first {
            return nil
        }
        
        return pages.first
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if viewController == pages.first {
            return pages[1]
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let vc = pageViewController.viewControllers?.first as? NumbersTableViewController else {
            return
        }
        
        self.changeScrollableView(vc.tableView)
    }
}
