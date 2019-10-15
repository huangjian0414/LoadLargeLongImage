//
//  ViewController.m
//  LargeLongImageShow
//
//  Created by huangjian on 2019/10/14.
//  Copyright © 2019 huangjian. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "LargeLongImgViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *titleArray;
@end

static NSString * cellID = @"cell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"加载大长图";
    [self setUpUI];
}
//MARK: - TableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            NSString *content = [NSString stringWithFormat:@"<html><body>%@</body></html>", [self htmlForJPGImage:[UIImage imageNamed:@"img777"]]];
            
            WebViewController *vc = [[WebViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            //vc.url = @"http://img.xidu98.com/data/postmsg/f295434b93e11d83ade0ae4796a8521e";
            vc.url = content;
        }
            break;
            
        case 1:
        {
            LargeLongImgViewController *vc = [[LargeLongImgViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

//MARK: - UI
-(void)setUpUI{
    UITableView *tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator=NO;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    tableView.rowHeight = 40;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

//MARK: - 加载本地长图，转html ， webView调loadHTMLString
- (NSString *)htmlForJPGImage:(UIImage *)image{
    NSData *imageData = UIImageJPEGRepresentation(image,1.f);
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    return [NSString stringWithFormat:@"<div align=center><img src='%@' /></div>", imageSource];
    
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"Web加载大长图",@"分片加载大长图"];
    }
    return _titleArray;
}

@end
