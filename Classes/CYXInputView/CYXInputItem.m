//
//  CYXInputItem.m
//  CYXCustomerInputView
//
//  Created by 晓 on 2019/12/6.
//  Copyright © 2019 陈泳晓. All rights reserved.
//

#import "CYXInputItem.h"
@interface CYXInputItem()
/*文本*/
@property (nonatomic,strong) UILabel *textLabel;
/*光标*/
@property (nonatomic,strong) UIView *cursorView;
/*底部线*/
@property (nonatomic,strong) UIView *lineView;
@end
@implementation CYXInputItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        [self addSubview:self.textLabel];
        [self addSubview:self.cursorView];
        [self addSubview:self.lineView];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
    self.cursorView.frame= CGRectMake(0, 0, 1, 14);
    self.cursorView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1);
}
-(void)setText:(NSString *)text isCurrentEdit:(BOOL)edit{
    self.textLabel.text = text;
    if (!edit) {
        [self.cursorView.layer removeAnimationForKey:@"kOpacityAnimation"];
    }else{
        [self.cursorView.layer addAnimation:[self opacityAnimation] forKey:@"kOpacityAnimation"];
    }
    self.lineView.backgroundColor = ([text length]||edit)?[UIColor blackColor]:[UIColor grayColor];
    [UIView animateWithDuration:0.25 animations:^{
        self.cursorView.hidden = !edit;
    }];
    [self setNeedsLayout];
}
/*闪烁动画*/
- (CABasicAnimation *)opacityAnimation {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @(1.0);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.duration = 0.9;
    opacityAnimation.repeatCount = HUGE_VALF;
    opacityAnimation.removedOnCompletion = YES;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    return opacityAnimation;
}
#pragma mark ---G
-(UILabel*)textLabel{
    if(!_textLabel){
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont boldSystemFontOfSize:18];
        _textLabel.textAlignment =NSTextAlignmentCenter;
        _textLabel.text = @"";
        _textLabel.textColor = [UIColor blackColor];
    }
    return _textLabel;
}
-(UIView*)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}
-(UIView*)cursorView{
    if(!_cursorView){
        _cursorView = [[UIView alloc] init];
        _cursorView.hidden = YES;
        _cursorView.backgroundColor = [UIColor redColor];
    }
    return _cursorView;
}
@end
