//
//  ViewController.m
//  MasoryDemo
//
//  Created by ZCD on 2017/6/1.
//  Copyright © 2017年 ZCD. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
// get  net:http://apistore.baidu.com/apiworks/servicedetail/112.html
// post net:http://www.juhe.cn/docs/api/id/46/aid/131

#define NSLOG(OBJECT) NSLog(@"%@", OBJECT)

#define Get_Url_Apikey @"159d95a8c050074fe3ca0df0d901fc62"
#define Get_Url_String @"http://apis.baidu.com/apistore/weatherservice/weather?citypinyin=chengdu"

#define Post_Url_Apikey @"由于有次数限制，故请进入上方 post net 网址，注册聚合账号，申请数据，填入自己申请的appkey"
#define Post_Url_String @"http://apis.juhe.cn/cook/queryid"
#define Post_Url_Parameter_Id @(1001)
#define Post_Url_Parameter_Dtype @"json"
@interface ViewController ()

@end

@implementation ViewController
/**
 //这个方法只会添加新的约束
 [blueView mas_makeConstraints:^(MASConstraintMaker *make)  {
 
 }];
 
 // 这个方法会将以前的所有约束删掉，添加新的约束
 [blueView mas_remakeConstraints:^(MASConstraintMaker *make) {
 
 }];
 
 // 这个方法将会覆盖以前的某些特定的约束
 [blueView mas_updateConstraints:^(MASConstraintMaker *make) {
 
 }];
 */
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIView *redView = [[UIView alloc]init];
//    redView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:redView];
//    
//    UIView *blueView = [[UIView alloc]init];
//    blueView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:blueView];
//    
//    UIView *yellow = [[UIView alloc]init];
//    yellow.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:yellow];
//    
//    UIView *green = [[UIView alloc]init];
//    green.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:green];
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);
//        make.height.equalTo(self.view.mas_height).multipliedBy(0.5);
//        make.center.equalTo(self.view.mas_centerX);
//    }];
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(0);//使左边等于self.view的左边，间距为0
//        make.top.equalTo(self.view.mas_top).offset(0);//使顶部与self.view的间距为0
//        make.width.equalTo(self.view.mas_width).multipliedBy(0.5);//设置宽度为self.view的一半，multipliedBy是倍数的意思，也就是，使宽度等于self.view宽度的0.5倍
//        make.height.equalTo(self.view.mas_height).multipliedBy(0.5);//设置高度为self.view高度的一半
//        
//    }];
//    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.equalTo(redView);//使宽高等于redView
//        make.top.equalTo(redView.mas_top);//与redView顶部对齐
//        make.left.equalTo(redView.mas_right);//与redView的间距为0
//    }];
//    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(redView);//与redView左对齐
//        make.top.equalTo(redView.mas_bottom);//与redView底部间距为0
//        make.width.and.height.equalTo(redView);//与redView宽高相等
//    }];
//    [green mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(yellow.mas_right);//与yellow右边间距为0
//        make.top.equalTo(blueView.mas_bottom);//与blueView底部间距为0
//        make.width.and.height.equalTo(redView);//与redView等宽高
//    }];
    [self postNetWorking:Post_Url_String];
}
#pragma mark 网络请求
-(void)getNetWorking:(NSString *)url{
    //1.构造URL资源地址
    NSURL *urlQuest = [NSURL URLWithString:url];
    //2.创建Request请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlQuest];
    //3.配置Request请求
    //设置请求方法
    request.HTTPMethod = @"GET";
    //设置请求超时
    request.timeoutInterval = 10.0;
    //设置头部参数
    [request addValue:Get_Url_Apikey forHTTPHeaderField:@"apiKey"];
    //4.构造NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 5、构造NSURLSession，网络会话；
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 6、构造NSURLSessionTask，会话任务；
    NSURLSessionTask *sessionTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //请求失败打印错误信息
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        //请求成功，解析数据
        else{
            // 直接将data数据转成OC字符串(NSUTF8StringEncoding)；
            // NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            // JSON数据格式解析
             id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            // 9、判断是否解析成功
            if (error) {
                NSLOG(error.localizedDescription);
            }else {
                NSLOG(object);
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面....
                });
            }
        }
    }];
    //7.执行任务
    [sessionTask resume];
    
}
#pragma mark post请求
-(void)postNetWorking:(NSString *)url{
    NSURL *postURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:postURL];
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    NSDictionary *parametersDict = @{@"id":Post_Url_Parameter_Id, @"key":Post_Url_Apikey, @"dtype":Post_Url_Parameter_Dtype};
     //遍历字典，以“key=value&”的方式创建参数字符串。
    NSMutableString *parameterString = [NSMutableString string];
    for (NSString *key in parametersDict.allKeys) {
        // 拼接字符串
        [parameterString appendFormat:@"%@=%@&", key, parametersDict[key]];
    }
    //截取参数字符串，去掉最后一个“&”，并且将其转成NSData数据类型。
    NSData *parametersData = [[parameterString substringToIndex:parameterString.length - 1] dataUsingEncoding:NSUTF8StringEncoding];
    //设置请求报文
    request.HTTPBody = parametersData;
    //构造NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error.localizedDescription);
        }else{
            //如果请求成功
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            //判断是否解析成功
            if (error) {
                 NSLOG(error.localizedDescription);
            }else{
                NSLOG(object);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面...
                });
            }
        }
    }];
    [task resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
