//
//  WeatherTableViewCell.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/30/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property(nonatomic, strong)IBOutlet UILabel *weekDay;
@property(nonatomic, strong)IBOutlet UILabel *temperature;
@property(nonatomic, strong)IBOutlet UILabel *date;
@property(nonatomic, strong)IBOutlet UIImageView *image;

@end
