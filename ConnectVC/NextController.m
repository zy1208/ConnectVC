//
//  NextController.m
//  ConnectVC
//
//  Created by Palmpay on 2018/6/21.
//  Copyright © 2018年 palm. All rights reserved.
//

#import "NextController.h"

@interface NextController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation NextController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加控件
    [self commonInit];
    
//    self.view.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //设置Layout
    [self setLayout];
}

#pragma mark -- 添加控件
- (void)commonInit {
    [self.view addSubview:self.contentLabel];
}

- (void)setLayout {
    self.contentLabel.frame = CGRectMake(100, 200, 200, 100);
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.text = [NSString stringWithFormat:@"%ld", (long)self.topic];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor orangeColor];
    }
    return _contentLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
