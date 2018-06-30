//
//  ContributionTableViewCell.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContributionTableViewCell : UITableViewCell

@property(nonatomic, retain)IBOutlet UILabel *name;
@property(nonatomic, retain)IBOutlet UILabel *desc;
@property(nonatomic, retain)IBOutlet UIImageView *image;

@end
