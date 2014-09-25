//
//  R2RFlightHopCell.m
//  Rome2Rio
//
//  Created by Ash Verdoorn on 14/09/12.
//  Copyright (c) 2012 Rome2Rio. All rights reserved.
//

#import "R2RFlightHopCell.h"


@implementation R2RFlightHopCell

@synthesize hopLabel, connectTop, connectBottom, icon;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initSubviews];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initSubviews
{
    self.connectTop = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, 6, self.contentView.frame.size.height/2)];
    [self.contentView addSubview:connectTop];
    
    self.connectBottom = [[UIImageView alloc] initWithFrame:CGRectMake(25, self.contentView.frame.size.height/2, 6, self.contentView.frame.size.height/2)];
    [self.contentView addSubview:connectBottom];
    
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(16, self.contentView.frame.size.height/2-12, 24, 24)];
    [self.contentView addSubview:icon];
}
@end
