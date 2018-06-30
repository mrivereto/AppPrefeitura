//
//  WeatherDetailTableViewCell.h
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 8/7/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailTableViewCell : UITableViewCell

@property(nonatomic, strong)IBOutlet UILabel *temperature;
@property(nonatomic, strong)IBOutlet UILabel *desc;
@property(nonatomic, strong)IBOutlet UIImageView *image;

@end
