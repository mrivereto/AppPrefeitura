//
//  EventTableViewCell.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell{


}

@property(nonatomic, retain) IBOutlet UILabel *cellTitle;
@property(nonatomic, retain) IBOutlet UILabel *cellLocation;
@property(nonatomic, retain) IBOutlet UILabel *cellPeriod;
@property(nonatomic, retain) IBOutlet UIImageView *cellImage;
@property(nonatomic, retain) IBOutlet UILabel *cellMonth;
@property(nonatomic, retain) IBOutlet UILabel *cellDay;

@end
