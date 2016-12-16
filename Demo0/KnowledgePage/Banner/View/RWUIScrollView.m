//
//  RWUIScrollView.m
//  Hello
//
//  Created by ray wang on 16/12/14.
//  Copyright © 2016年 ray wang. All rights reserved.
//

#import "RWUIScrollView.h"

@implementation RWUIScrollView

-(void) setStyle1{
    self.frame=CGRectMake(0,0,375,190.5);


    self.pagingEnabled= YES;
    self.scrollEnabled=YES;
    self.showsVerticalScrollIndicator=NO;
    self.showsHorizontalScrollIndicator=NO;
    self.bounces=YES;
    self.alwaysBounceVertical=NO;
    self.alwaysBounceHorizontal=YES;
    self.backgroundColor= [UIColor blueColor];
}

-(void) LoadImages{
    for(int i=0;i<3;i++){
        NSString * imgName=[NSString stringWithFormat:@"%d.jpg",i+1];
        UIImage * anImage=[UIImage imageNamed:imgName];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 200) ];
        imageView.image=anImage;
        [self addSubview:imageView];
    }
}
@end
