
//
//  HHStatusFrame.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/9.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHStatusFrame.h"
#import "HHStatus.h"
#import "HHUser.h"
#import "HHStatusPhotosView.h"

// cell的边框高
#define HHStatusCellBorderW 10



@implementation HHStatusFrame


- (void)setStatus:(HHStatus *)status{
    
    _status = status;
    
    HHUser *user = status.user;
    
    // cell宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 头像 */
    CGFloat iconWH = 35;
    CGFloat iconX = HHStatusCellBorderW;
    CGFloat iconY = HHStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HHStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name stringSizeWithFont:HHStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    
    /** 会员图标 */
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HHStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HHStatusCellBorderW;
    CGSize timeSize = [status.created_at stringSizeWithFont:HHStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HHStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source stringSizeWithFont:HHStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};

    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + HHStatusCellBorderW;
    CGFloat maxWidth = cellW - 2 * HHStatusCellBorderW;
    CGSize contentSize = [status.attributedText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + HHStatusCellBorderW;
        CGSize photosSize = [HHStatusPhotosView SizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX, photosY}, photosSize};
        originalH = CGRectGetMaxY(self.photosViewF) + HHStatusCellBorderW;
    } else { // 无配图
        originalH = CGRectGetMaxY(self.contentLabelF) + HHStatusCellBorderW;
    }
   
    
    
    /* 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = HHStatusCellMargin; // cell顶部间隔
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    /* toolbarY*/
    CGFloat toolbarY =  0;

    /* 转发微博整体 */
    if (status.retweeted_status) {
        /** 转发微博正文 */
        
        HHStatus *retweeted_status = status.retweeted_status;
//        HHUser *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = HHStatusCellBorderW;
        CGFloat retweetContentY = HHStatusCellBorderW;
//        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [status.retweetedAttributedText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        /** 转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
           
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + HHStatusCellBorderW;
            CGSize retweetPhotosSize = [HHStatusPhotosView SizeWithCount:retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosX, retweetPhotosY}, retweetPhotosSize};
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + HHStatusCellBorderW;
        } else { // 转发微博没有配图
            
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HHStatusCellBorderW;

        }
        
        /** 转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);

        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /* 工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    
    /** cell高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF);

    
}

@end
