//
//  CYXInputView.m
//  CYXCustomerInputView
//
//  Created by 晓 on 2019/12/6.
//  Copyright © 2019 陈泳晓. All rights reserved.
//
#pragma mark ---Views
#import "CYXInputView.h"
#import "CYXInputItem.h"
@interface CYXInputView()
/*输入内容*/
@property (nonatomic, copy) NSMutableString *text;
@property (nonatomic, assign) BOOL isShow;
/*item列表*/
@property (nonatomic,strong) NSMutableArray<CYXInputItem *> *itemList;
/*输入字符数*/
@property (nonatomic,assign) NSInteger input_number;
@end
@implementation CYXInputView
- (instancetype)initWithFrame:(CGRect)frame withInputNumber:(NSInteger)input_number{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.input_number = input_number;
        self.insets = UIEdgeInsetsMake(0, 15, 0, 15);
        self.itemSpace = 16;
        [self initViews];
    }
    return self;
}

- (void)clearText {
    self.text = [NSMutableString string];
    [self setNeedsLayout];
}
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}
- (BOOL)becomeFirstResponder {
    if (!self.isShow) {
//        if ([self.delegate respondsToSelector:@selector(passwordInputViewBeginInput:)]) {
//            [self.delegate passwordInputViewBeginInput:self];
//        }
    }
    self.isShow = YES;
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    if (self.isShow) {
//        if ([self.delegate respondsToSelector:@selector(passwordInputViewEndInput:)]) {
//            [self.delegate passwordInputViewEndInput:self];
//        }
    }
    self.isShow = NO;
    return [super resignFirstResponder];
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (BOOL)canResignFirstResponder {
    return YES;
}
- (BOOL)isSecureTextEntry {
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateItems];
}
#pragma mark ---Private
-(void)initViews{
    self.itemList = [[NSMutableArray alloc] initWithCapacity:self.input_number];
    for (int i = 0; i<self.input_number; i++) {
        CYXInputItem * item =[CYXInputItem new];
        [self.itemList addObject:item];
        [self addSubview:item];
    }
}
/*更新UI*/
-(void)updateItems{
    if (![self.itemList count]) {return;}
    CGFloat top = self.insets.top;
    CGFloat height = CGRectGetHeight(self.frame) - top - self.insets.bottom;
    CGFloat width = (CGRectGetWidth(self.frame)-self.insets.left-self.insets.right-([self.itemList count]-1)*self.itemSpace)/[self.itemList count];
    CGFloat left = self.insets.left;
    for (int i = 0; i<self.itemList.count; i++) {
        CYXInputItem * item = self.itemList[i];
        item.frame = CGRectMake(left+i*(self.itemSpace+width), top, width, height);
    }
}
#pragma mark ---UIKeyInput
- (BOOL)hasText {
    return self.text.length > 0;
}
- (void)insertText:(NSString *)text {
    if (self.text.length < self.input_number) {
        //判断是否是数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString*filtered = [[text componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [text isEqualToString:filtered];
        if(basicTest) {
            [self.text appendString:text];
//            if ([self.delegate respondsToSelector:@selector(passwordInputViewDidChange:)]) {
//                [self.delegate passwordInputViewDidChange:self];
//            }
//            if (self.text.length == self.input_number) {
//                if ([self.delegate respondsToSelector:@selector(passwordInputViewCompleteInput:)]) {
//                    [self.delegate passwordInputViewCompleteInput:self];
//                }
//            }
            [self setNeedsDisplay];
        }
    }
}
- (void)deleteBackward {
    if (self.text.length > 0) {
        [self.text deleteCharactersInRange:NSMakeRange(self.text.length - 1, 1)];
//        if ([self.delegate respondsToSelector:@selector(passwordInputViewDidChange:)]) {
//            [self.delegate passwordInputViewDidChange:self];
//        }
    }
//    if ([self.delegate respondsToSelector:@selector(passwordInputViewDidDeleteBackward:)]) {
//        [self.delegate passwordInputViewDidDeleteBackward:self];
//    }
    [self setNeedsDisplay];
}
#pragma mark ---G
-(NSMutableString*)text{
    if(!_text){
        _text = [NSMutableString string];
    }
    return _text;
}

@end
