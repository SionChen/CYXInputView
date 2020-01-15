//
//  CYXInputView.h
//  CYXCustomerInputView
//
//  Created by 晓 on 2019/12/6.
//  Copyright © 2019 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYXInputView : UIView<UIKeyInput>
#pragma mark ---PublicProperty
/*输入内容*/
@property (nonatomic, copy, readonly) NSMutableString *text;
/*输入字符数*/
@property (nonatomic,assign,readonly) NSInteger input_number;
/*四周边距 默认 上 0 左 15 下 0 右 15 */
@property (nonatomic,assign) UIEdgeInsets insets;
/*item间距默认16*/
@property (nonatomic,assign) CGFloat itemSpace;
#pragma mark ---PublicMotheds
/*初始化方法*/
- (instancetype)initWithFrame:(CGRect)frame withInputNumber:(NSInteger)input_number;
/*清楚文字*/
- (void)clearText;
@end

NS_ASSUME_NONNULL_END
