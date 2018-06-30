//
//  WeatherTableViewCell.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 6/30/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

@synthesize weekDay, temperature, image, date;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
