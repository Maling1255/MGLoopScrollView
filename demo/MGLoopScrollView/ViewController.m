//
//  ViewController.m
//  MGLoopScrollView
//
//  Created by maling on 2018/11/29.
//  Copyright © 2018 maling. All rights reserved.
//


#import "ViewController.h"

#import "MGLoopScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 30)];

    lbl.font = [UIFont systemFontOfSize:25];
    
    lbl.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:lbl];
    
    
   MGLoopScrollView *loopScrollView = [MGLoopScrollView instanceView:self.view];
 
   loopScrollView.images = @[[UIImage imageNamed:@"001.jpg"],
                             [UIImage imageNamed:@"002.jpg"],
                             [UIImage imageNamed:@"003.jpg"],
                             [UIImage imageNamed:@"004.jpg"],
                             [UIImage imageNamed:@"005.jpg"]].mutableCopy;
    
    [loopScrollView setTapEvent:^(NSInteger index) {
        
        lbl.text = [NSString stringWithFormat:@"当前点击的是： %ld 个图片", index];
        
    }];

}


@end
