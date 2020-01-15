//
//  CYXCodeInputView.h
//  CYXCustomerInputView
//
//  Created by 晓 on 2019/12/9.
//  Copyright © 2019 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface CYXCodeInputView : UIView
/*输入内容*/
@property (nonatomic, copy, readonly) NSMutableString *text;
/*验证码输入个数*/
@property(nonatomic,assign,readonly)NSInteger inputNum;
/*四周边距 默认 上 0 左 15 下 0 右 15 */
@property (nonatomic,assign) UIEdgeInsets insets;
/*item间距默认16*/
@property (nonatomic,assign) CGFloat itemSpace;
/*构造方法*/
- (instancetype)initWithFrame:(CGRect)frame
                    inputType:(NSInteger)inputNum;
@end

NS_ASSUME_NONNULL_END
