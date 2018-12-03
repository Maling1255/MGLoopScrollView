//
//  MGLoopScrollView.h
//  MGLoopScrollView
//
//  Created by maling on 2018/11/29.
//  Copyright © 2018 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGLoopScrollView : UIView

@property (nonatomic, strong) NSMutableArray <UIImage *>*images;

@property (nonatomic, copy) void(^tapEvent)(NSInteger index);

+ (instancetype)instanceView:(UIView *)bgView;


@end

NS_ASSUME_NONNULL_END
