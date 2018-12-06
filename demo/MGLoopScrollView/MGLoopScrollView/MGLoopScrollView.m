//
//  MGLoopScrollView.m
//  MGLoopScrollView
//
//  Created by maling on 2018/11/29.
//  Copyright © 2018 maling. All rights reserved.
//

#import "MGLoopScrollView.h"
#import "UIView+Frame.h"
#import <stdatomic.h>
#import "MGImageView.h"

#define MGSCREENWIDTH                 ([UIScreen mainScreen].bounds.size.width)
#define MGSCREENHEIGHT                ([UIScreen mainScreen].bounds.size.height)

static NSString *const MGRight = @"MGRight";
static NSString *const MGLeft = @"MGLeft";
static NSString *const MGNull = @"MGNull";

@interface MGLoopScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray <UIImage *>*imageArr;
@property (nonatomic, strong) NSMutableArray <MGImageView *>*imageViewArray;
@property (nonatomic, strong) UIScrollView *scrollView;

/// 滑动方向
@property (nonatomic, copy) NSString *direction;
/// 记录当前页索引
@property (nonatomic, assign) NSInteger currentPage;
    
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation MGLoopScrollView

+ (instancetype)instanceView:(UIView *)bgView
{
    MGLoopScrollView *instanceView = [[MGLoopScrollView alloc] initWithView:bgView];
    
    [bgView addSubview:instanceView];
    
    return instanceView;
}

- (instancetype)initWithView:(UIView *)bgView
{
    if (self = [super init]) {
        
        self.frame = CGRectMake(30, 220, MGSCREENWIDTH - 30 * 2, 200);
        
        _currentPage = 1;
        
        [self setupSubviews];
    }
    return self;
}

- (void)setImages:(NSMutableArray<UIImage *> *)images
{
    self.imageArr = images;
    
    for (int i = 1; i <= 3; i++) {
        
        MGImageView *imageView = [[MGImageView alloc] initWithFrame:CGRectMake(self.scrollView.width * (i - 1), 0, self.scrollView.width, self.scrollView.height)];
        
        imageView.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:imageView];
        
        if (i == 1) {
            imageView.image = self.imageArr.lastObject;
        }
        
        if (i == 2) {
            imageView.image = self.imageArr[0];
        }
        
        if (i == 3) {
            imageView.image = self.imageArr[1];
        }
        
        [self.imageViewArray addObject:imageView];
        
        
    }
    
    MGImageView *currentImageView = self.imageViewArray[1];
    
    UITapGestureRecognizer *panges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEvent)];
    
    [currentImageView addGestureRecognizer:panges];
    
    UISwipeGestureRecognizer *swipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGes:)];
    
    [currentImageView addGestureRecognizer:swipeGes];
    
    
    [self setupTimer];
}

- (void)setupTimer
{
    if (self.timer == nil) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(roopIndex:) userInfo:@(self.imageArr.count) repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
//        self.timer = timer;
    }
    
}

- (void)roopIndex:(NSTimer *)timer
{
    NSInteger count = [timer.userInfo integerValue];
    
    _currentPage ++;
    
    if (_currentPage == count + 1) {
     
        _currentPage = 1;
    }
    
    [self.scrollView setContentOffset:CGPointMake(_scrollView.width * 2, 0) animated:YES];
    
}
    
- (void)clickEvent
{
    if (self.tapEvent) {
        
        self.tapEvent(_currentPage == 0 ? self.imageArr.count : _currentPage);
    }
}

- (void)swipeGes:(UIGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"《《《《《《《《《《《《《《《《《 开始青少");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"。。。。。。。。。。。。。。。。。。。结束");
    }
}

- (void)setupSubviews
{
    self.backgroundColor = [UIColor lightGrayColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    self.scrollView = scrollView;
    
    scrollView.userInteractionEnabled = YES;
    
    scrollView.contentSize = CGSizeMake(self.width * 3, self.height);
    
    scrollView.contentOffset = CGPointMake(self.width, 0);
    
    scrollView.pagingEnabled = YES;
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    [self addSubview:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
//    NSLog(@">>> %f", offsetX);
    
    // 定时器设置完归位置
    if (self.timer && offsetX == self.scrollView.width * 2) {
        
//        [self.scrollView setContentOffset:CGPointMake(_scrollView.width , 0) animated:NO];
        
        [self setImagviewAndScrollViewContentOffset:offsetX / 2 index:0];
    }
    
    // 向左 ◀️
    if (offsetX < self.width) {
        
        _direction = MGLeft;
    }
    
   // 向右 ▶️
    if (offsetX > self.width)
    {
        _direction = MGRight;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    NSInteger index = offsetX / self.width;
    
    [self setImagviewAndScrollViewContentOffset:offsetX index:index];
    
    if (self.timer) {
        
        NSLog(@">>>>>>>>>  存在定时器");
        
//        self.timer = nil;
//        [self.timer invalidate];
        
        
        
//        [self setupTimer];
    }
    
}

- (void)setImagviewAndScrollViewContentOffset:(CGFloat)offsetX index:(NSInteger)index
{
    if (offsetX == self.width) {
        
        _direction = MGNull;
    }
    
    if ([_direction isEqualToString:MGRight] && _currentPage < _imageArr.count) {
        _currentPage += 1;
    }
    else if ([_direction isEqualToString:MGRight] && _currentPage == _imageArr.count)
    {
        _currentPage = 1;
    }
    else if ([_direction isEqualToString:MGLeft] && _currentPage > 1)
    {
        _currentPage -= 1;
    }
    else if ([_direction isEqualToString:MGLeft] && _currentPage == 1)
    {
        _currentPage = _imageArr.count;
    }
    else if ([_direction isEqualToString:MGLeft] && _currentPage == 0)
    {
        _currentPage = _imageArr.count - 1;
    }
    
    
    if (index == 2 || index == 0) {
        
        [self.scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
        
        if (_currentPage == 1)
        {
            //            NSLog(@"上一个index：  %ld", self.imageArr.count - 1);
            
            self.imageViewArray[0].image = self.imageArr[self.imageArr.count - 1];
        }
        else
        {
            //            NSLog(@"上一个index： %ld  当前： %ld", _currentPage - 2,   _currentPage);
            
            self.imageViewArray[0].image = self.imageArr[_currentPage - 2];
        }
        
        
        self.imageViewArray[1].image = self.imageArr[_currentPage - 1];
        
        if (_currentPage == _imageArr.count) {
            
            self.imageViewArray[2].image = self.imageArr[0];
        }
        else
        {
            self.imageViewArray[2].image = self.imageArr[_currentPage];
        }
    }
    
    // 循序向右滑动
    if (_currentPage == _imageArr.count && [_direction isEqualToString:MGRight]) {
        
        _currentPage = 0;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>sssssssssssstart");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>end");
}

- (NSMutableArray <MGImageView *>*)imageViewArray
{
    if (!_imageViewArray) {
        _imageViewArray = [[NSMutableArray alloc] init];
    }
    return _imageViewArray;
}

- (void)dealloc
{
    self.timer = nil;
    [self.timer invalidate];
}

@end
