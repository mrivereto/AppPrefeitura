//
//  MenuViewController.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 8/14/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate>{
    
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnChange;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UITableView *tableView;
-(IBAction)changeView:(UIButton *)sender;

@end
