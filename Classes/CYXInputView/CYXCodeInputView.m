//
//  CYXCodeInputView.m
//  CYXCustomerInputView
//
//  Created by 晓 on 2019/12/9.
//  Copyright © 2019 陈泳晓. All rights reserved.
//

#import "CYXCodeInputView.h"
#import "CYXInputItem.h"
@interface CYXCodeInputView()<UITextViewDelegate>
@property(nonatomic,assign)NSInteger inputNum;//验证码输入个数（4或6个）
/*item列表*/
@property (nonatomic,strong) NSMutableArray<CYXInputItem *> *itemList;
@property(nonatomic,strong)UITextView * textView;
@end
@implementation CYXCodeInputView
- (instancetype)initWithFrame:(CGRect)frame
                    inputType:(NSInteger)inputNum{
    if (self = [super initWithFrame:frame]) {
        self.inputNum = inputNum;
        self.insets = UIEdgeInsetsMake(0, 15, 0, 15);
        self.itemSpace = 16;
        [self initViews];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self updateItems];
}
#pragma mark ---Private
-(void)initViews{
    self.itemList = [[NSMutableArray alloc] initWithCapacity:self.inputNum];
    for (int i = 0; i<self.inputNum; i++) {
        CYXInputItem * item =[CYXInputItem new];
        [self.itemList addObject:item];
        [self addSubview:item];
    }
    [self addSubview:self.textView];
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
    self.textView.frame = self.bounds;
}
/*开始编辑*/
- (void)beginEdit{
    [self.textView becomeFirstResponder];
}
/*结束编辑*/
- (void)endEdit{
    [self.textView resignFirstResponder];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    NSString *verStr = textView.text;
    if (verStr.length > _inputNum) {
        textView.text = [textView.text substringToIndex:_inputNum];
    }
    //大于等于最大值时, 结束编辑
    if (verStr.length >= _inputNum) {
        [self endEdit];
    }
    for (int i = 0; i < self.itemList.count; i ++) {
        CYXInputItem * item = self.itemList[i];
        if (i < verStr.length) {
            [item setText:[verStr substringWithRange:NSMakeRange(i, 1)] isCurrentEdit:NO];
        }else {
            [item setText:@"" isCurrentEdit:(i == verStr.length&&[textView isFirstResponder]) ? YES : NO];
        }
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.text.length<self.inputNum) {
        [self textViewDidChange:textView];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length<self.inputNum) {
        [self textViewDidChange:textView];
    }
}
#pragma mark ---G
- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.tintColor = [UIColor clearColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textView;
}

@end
