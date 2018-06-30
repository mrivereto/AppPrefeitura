//
//  NewsTableViewCell.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/21/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell{

}

@property(nonatomic, retain) IBOutlet UILabel *cellTitle;
@property(nonatomic, retain) IBOutlet UILabel *cellResume;
@property(nonatomic, retain) IBOutlet UILabel *cellMonth;
@property(nonatomic, retain) IBOutlet UILabel *cellDay;
@property(nonatomic, retain) IBOutlet UIImageView *cellImage;


@end
