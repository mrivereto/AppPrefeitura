//
//  ContributionTableViewCell.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 7/12/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "ContributionTableViewCell.h"

@implementation ContributionTableViewCell

@synthesize name, desc, image;

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
