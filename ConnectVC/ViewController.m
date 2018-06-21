//
//  ViewController.m
//  ConnectVC
//
//  Created by Palmpay on 2018/6/21.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "ViewController.h"
#import "NextController.h"

#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
//title
@property (nonatomic, strong) UIView *titleView;
//indicator
@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //添加控制器
    [self addVC];
    //添加titleView控件
    [self addTitleView];
    //添加contentView
    [self addContentView];
}

#pragma mark -- 添加控制器
- (void)addVC {
    NextController *all = [[NextController alloc] init];
    all.title = @"全部";
    all.topic = 0;
    [self addChildViewController:all];
    
    NextController *video = [[NextController alloc] init];
    video.title = @"视频";
    video.topic = 1;
    [self addChildViewController:video];
    
    NextController *voice = [[NextController alloc] init];
    voice.title = @"声音";
    voice.topic = 2;
    [self addChildViewController:voice];
    
    NextController *photo = [[NextController alloc] init];
    photo.title = @"图片";
    photo.topic = 3;
    [self addChildViewController:photo];
    
    NextController *story = [[NextController alloc] init];
    story.title = @"段子";
    story.topic = 4;
    [self addChildViewController:story];
}

#pragma mark -- 添加titleView
- (void)addTitleView {
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = [UIColor yellowColor];
    self.titleView.frame = CGRectMake(0, 20, self.view.width, 37);
    [self.view addSubview:self.titleView];
    
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor greenColor];
    self.indicatorView.tag = -1;
    CGRect indicatorRect = self.indicatorView.frame;
    indicatorRect.size.height = 2;
    indicatorRect.origin.y = self.titleView.frame.size.height - indicatorRect.size.height;
    self.indicatorView.frame = indicatorRect;

    
    CGFloat margin = 5;
    for (int i = 0; i < self.childViewControllers.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBackgroundColor:[UIColor cyanColor]];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        
        CGFloat btnW = (self.titleView.width - 6 *margin) / self.childViewControllers.count;
        CGFloat btnH = self.titleView.height - self.indicatorView.height;
        CGFloat btnY = 0;
        CGFloat btnX = (btnW + margin) *i + margin;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [self.titleView addSubview:btn];
        
        if (i == 0) {
            btn.selected = NO;
            
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
    }
    [self.titleView addSubview:self.indicatorView];
}

#pragma mark -- 添加contentView
- (void)addContentView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.contentSize = CGSizeMake(self.childViewControllers.count *contentView.width, 0);
    self.contentView = contentView;
    [self.view insertSubview:self.contentView atIndex:0];
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark -- 按钮点击事件
- (void)btnDidClick:(UIButton *)sender {
    sender.enabled = NO;
    self.selectBtn.enabled = YES;
    self.selectBtn = sender;

    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
    
    CGPoint contentOffset = self.contentView.contentOffset;
    contentOffset.x = sender.tag *self.contentView.width;
    [self.contentView setContentOffset:contentOffset animated:YES];
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int current = scrollView.contentOffset.x / scrollView.width;
    NextController *vc = self.childViewControllers[current];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    [self.contentView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self btnDidClick:self.titleView.subviews[index]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
