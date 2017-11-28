//
//  JRFBTextViewController.m
//  iOSFileBroswer
//
//  Created by 王俊仁 on 2017/11/28.
//  Copyright © 2017年 J. All rights reserved.
//

#import "JRFBTextViewController.h"

@interface JRFBTextViewController ()

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation JRFBTextViewController

- (instancetype)initWithText:(NSString *)text {
    if (self = [super init]) {
        _text = text;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    _textView = [[UITextView alloc] init];
    [self.view addSubview:_textView];
    _textView.editable = NO;

    _textView.text = _text;

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textView.frame = self.view.bounds;
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
