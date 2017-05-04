//
//  HHComposeVC.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/13.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHComposeVC.h"
#import "HHAccountTool.h"
#import "HHComposeToolbar.h"
#import "HHComposePhotosView.h"
#import "HHEmotionKeyboard.h"
#import "HHEmotion.h"
#import "HHEmotionTextView.h"

@interface HHComposeVC ()<UITextViewDelegate,HHComposeToolbarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 输入控件 */
@property (nonatomic, weak) HHEmotionTextView *textView;

/** 键盘顶部工具条 */
@property (nonatomic, weak) HHComposeToolbar *toolbar;

/** 相册 */
@property (nonatomic, weak) HHComposePhotosView *photosView;

/** 表情键盘 */
@property (nonatomic, strong) HHEmotionKeyboard *emotionKeyboard;

/** 是否正在切换键盘 */
@property (nonatomic, assign) BOOL switchingKeyboard;


@end

@implementation HHComposeVC

- (HHEmotionKeyboard *)emotionKeyboard{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[HHEmotionKeyboard alloc] init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;

    }
    return _emotionKeyboard;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    [self setupPhotosView];
    
    
    // 成为第一响应者（能呼出键盘）
    [self.textView becomeFirstResponder];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 成为第一响应者（能呼出键盘）
//    [self.textView becomeFirstResponder];

}

#pragma mark ------设置图片------
- (void)setupPhotosView{
    HHComposePhotosView *photosView = [[HHComposePhotosView alloc] init];
//    photosView.backgroundColor = [UIColor redColor];
    photosView.y = 100;
    photosView.width = self.view.width;
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    
    self.photosView = photosView;
}



#pragma mark ------设置工具条------
- (void)setupToolbar{
    HHComposeToolbar *toolbar = [[HHComposeToolbar alloc] init];
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
}


#pragma mark ------设置输入控件------
- (void)setupTextView{
    
    HHEmotionTextView *textView = [[HHEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事...";
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    // 文字改变通知
    [HHNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 键盘出现通知
    [HHNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 选中表情通知
    [HHNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:HHEmotionDidSelectNotification object:nil];
    
    // 删除文字通知
    [HHNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:HHEmotionDidDeleteNotification object:nil];
}

#pragma mark ------表情输入监听------
- (void)emotionDidSelect:(NSNotification *)notification{
    HHEmotion *emotion = notification.userInfo[HHSelectEmotionKey];
    [self.textView insertEmotion:emotion];
}
#pragma mark ------表情删除监听------
- (void)emotionDidDelete{
    // 删除最后的文字
    [self.textView deleteBackward];
}


#pragma mark ------监听键盘高度改变------
- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    if (self.switchingKeyboard) return; // 切换键盘时不执行
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        
        // 若出现工具条消失的情况，就用下面代码替换self.toolbar.y
//        if (keyboardF.origin.y > self.view.height) {
//            self.toolbar.y = self.view.height - self.toolbar.height;
//        } else {
//            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
//        }
    }];
//    HLog(@"%@",NSStringFromCGRect(self.toolbar.frame));
}


#pragma mark ------监听文字改变------
- (void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}


- (void)dealloc{
    [HHNotificationCenter removeObserver:self];
}

#pragma mark ------设置导航------
- (void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [HHAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 44;
        titleView.numberOfLines = 0;
        titleView.textAlignment = NSTextAlignmentCenter;
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:HHRGBColor(200, 200, 200) range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}


#pragma mark ------取消------
- (void)cancel{
    [self.view endEditing:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark ------发送------
- (void)send{
    
    // 纯文字发布
    // https://api.weibo.com/2/statuses/update.json
    
    // 图片和文字发布
    // https://upload.api.weibo.com/2/statuses/upload.json
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark ------发送带图微博------
- (void)sendWithImage{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HHAccount *account = [HHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.fullText;
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发布成功"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        
    }];

    
}

#pragma mark ------发送无图微博------
- (void)sendWithoutImage{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HHAccount *account = [HHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"status"] = self.textView.fullText;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发布成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HLog(@"请求失败-%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


#pragma mark ------composeToolbarDelegate------
- (void)composeToolbar:(HHComposeToolbar *)toolbar DidClcikButton:(HHComposeToolbarButtonType)buttonType{
    switch (buttonType) {
        case HHComposeToolbarButtonTypeCamera:  // 拍照
            [self openCamera];
            break;
        case HHComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
        case HHComposeToolbarButtonTypeMention: // @
            
            break;
        case HHComposeToolbarButtonTypeTrend:   // 话题
            
            break;
        case HHComposeToolbarButtonTypeEmotion: // 表情/键盘
            [self switchKeyboard];
            break;
            
        default:
            break;
    }
}

#pragma mark ------切换键盘------
- (void)switchKeyboard{
    // 开始切换键盘
    self.switchingKeyboard = YES;

    if (self.textView.inputView == nil) {
        
        self.textView.inputView = self.emotionKeyboard;
        
        // 显示键盘图标
        self.toolbar.showKeyboardButton = YES;
        
    } else {
        self.textView.inputView = nil;
        
        // 显示表情图标
        self.toolbar.showKeyboardButton = NO;

    }
    
    
    // 退出键盘
    [self.textView endEditing:YES];
//    [self.view endEditing:YES];
//    [self.view.window endEditing:YES];
//    [self.textView resignFirstResponder];
    
    // 弹出键盘
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.switchingKeyboard = NO;
        [self.textView becomeFirstResponder];

//    });

}



#pragma mark ------拍照------
- (void)openCamera{
    // 自定义图片选择器需要利用AssetsLibrary.framework，来获得手机上的所有图片资源
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark ------选择图片------
- (void)openAlbum{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];

}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];

}

#pragma mark ------UIImagePickerControllerDelegate------

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addPhoto:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
