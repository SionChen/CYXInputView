//
//  CYXInputItem.h
//  CYXCustomerInputView
//
//  Created by 晓 on 2019/12/6.
//  Copyright © 2019 陈泳晓. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYXInputItem : UIView


/// 状态设置
/// @param text text
/// @param edit 是否是正在编辑
-(void)setText:(NSString *)text isCurrentEdit:(BOOL)edit;
@end

NS_ASSUME_NONNULL_END
