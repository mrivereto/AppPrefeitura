//
//  JobTableViewCell.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/22/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobTableViewCell : UITableViewCell{

}

@property(nonatomic, retain) IBOutlet UILabel *cellTitle;
@property(nonatomic, retain) IBOutlet UILabel *cellPublicationDate;
@property(nonatomic, retain) IBOutlet UIImageView *cellImage;

@end
