//
//  HHStatusFrame.h
//  嗨微博
//
//  Created by 胡明正 on 2017/4/9.
//  Copyright © 2017年 huhuge. All rights reserved.
// 一个HHStatusFrame模型里面包含的信息
// 1.存放着一个cell内部所有子控件的frame数据
// 2.存放一个cell的高度
// 3.存放着一个数据模型HHStatus

// 昵称字体大小
#define HHStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体大小
#define HHStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体大小
#define HHStatusCellSourceFont [UIFont systemFontOfSize:12]
// 正文字体大小
#define HHStatusCellContentFont [UIFont systemFontOfSize:14]

// 转发微博正文字体大小
#define HHRetweetStatusCellContentFont [UIFont systemFontOfSize:13]

// cell之间间距
#define HHStatusCellMargin 15


#import <Foundation/Foundation.h>
@class HHStatus;


@interface HHStatusFrame : NSObject

@property (nonatomic, strong) HHStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;


/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发微博配图 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;

/** 底部工具条 */
@property (nonatomic, assign) CGRect toolbarF;


/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
