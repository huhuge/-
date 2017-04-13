//
//  HHStatusCell.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/9.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatusCell.h"
#import "HHStatus.h"
#import "HHStatusFrame.h"
#import "HHUser.h"
#import "HHPhoto.h"
#import "HHStatusToolbar.h"
#import "HHStatusPhotosView.h"
#import "HHIconView.h"

@interface HHStatusCell()

/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) HHIconView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) HHStatusPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) HHStatusPhotosView *retweetPhotosView;

/* 工具条 */
/** 工具条 */
@property (nonatomic, weak) HHStatusToolbar *toolbar;


@end

@implementation HHStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"status";
    HHStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HHStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;

}

//- (void)setFrame:(CGRect)frame{
//    frame.origin.y += HHStatusCellMargin;
//    [super setFrame:frame];
//}

/** cell初始化，一个cell调用一次 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone; // 取消点击效果
//        self.selectedBackgroundView.backgroundColor = [UIColor purpleColor];// 没有用
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        [self setupToolbar];
    }
    return self;
    
}

#pragma mark ------初始化工具条------
- (void)setupToolbar{
    HHStatusToolbar *toolbar = [HHStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}


#pragma mark ------初始化转发微博------
- (void)setupRetweet{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = HHRGBColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = HHRetweetStatusCellContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发微博配图 */
    HHStatusPhotosView *retweetPhotosView = [[HHStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;


    
}


#pragma mark ------初始原创微博------
- (void)setupOriginal{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    HHIconView *iconView = [[HHIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    HHStatusPhotosView *photosView = [[HHStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HHStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = HHStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = HHStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = HHStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}


-(void)setStatusFrame:(HHStatusFrame *)statusFrame{
    
    _statusFrame = statusFrame;
    
    HHStatus *status = statusFrame.status;
    HHUser *user = status.user;
    
    /** 原创微博整体 */
    
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    /** 会员图标 */
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
//        self.photosView.backgroundColor = [UIColor redColor];
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    /** 时间 */
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    if ([status.created_at isEqualToString:@"刚刚"]) {
        self.timeLabel.textColor = [UIColor orangeColor];
    }else{
        self.timeLabel.textColor = [UIColor grayColor];
    }
    
    /** 来源 */
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.textColor = [UIColor grayColor];
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;

    /* 被转发微博 */
    if (status.retweeted_status) {
        
        HHStatus *retweeted_status = status.retweeted_status;
        HHUser *retweeted_status_user = retweeted_status.user;
        /** 被转发微博整体 */
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
//            self.retweetPhotosView.backgroundColor = [UIColor redColor];
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
        
    } else {
        self.retweetView.hidden = YES;
    }
    
    /** 工具条 */
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
