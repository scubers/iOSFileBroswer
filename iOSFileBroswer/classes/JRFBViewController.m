//  JRFBViewController.m
//  iOSFileBroswer
//
//  Created by J on 2016/11/15.
//  Copyright © 2016年 J. All rights reserved.
//

#import "JRFBViewController.h"
#import "JRFBFile.h"
#import "JRFBTextViewController.h"

@interface JRFBViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *path;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<JRFBFile *> *files;

@end

@implementation JRFBViewController

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _path = path;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self.view addSubview:self.tableView];
}

- (void)setupData {
    if (!_path.length) {
        _path = NSHomeDirectory();
    }
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSError *error;
    NSArray<NSString *> *filenames = [mgr contentsOfDirectoryAtPath:_path error:&error];
    
    [filenames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JRFBFile *file = [JRFBFile new];
        file.name = obj;
        file.path = [_path stringByAppendingPathComponent:obj];
        BOOL isDirecotry = NO;
        if ([mgr fileExistsAtPath:file.path isDirectory:&isDirecotry]) {
            file.isDirectory = isDirecotry;
            [self.files addObject:file];
        }
    }];
}

#pragma mark <delegate, datasource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JRFBFile *file = self.files[indexPath.row];
    if (file.isDirectory) {
        JRFBViewController *vc = [[JRFBViewController alloc] initWithPath:file.path];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        // air drop 分享

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

        [alert addAction:[UIAlertAction actionWithTitle:@"AirDrop" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL fileURLWithPath:file.path]] applicationActivities:nil];
            [self presentViewController:vc animated:YES completion:nil];
        }]];

        [alert addAction:[UIAlertAction actionWithTitle:@"使用文本打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSError *error;
            NSString *text = [NSString stringWithContentsOfFile:file.path encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                [self alertMsg:[error description]];
            } else {
                JRFBTextViewController *vc = [[JRFBTextViewController alloc] initWithText:text];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];

        [self presentViewController:alert animated:YES completion:nil];

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    JRFBFile *file = self.files[indexPath.row];
    cell.textLabel.text = file.name;
    cell.accessoryType = file.isDirectory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray<JRFBFile *> *)files {
    if (!_files) {
        _files = [[NSMutableArray<JRFBFile *> alloc] init];
    }
    return _files;
}

- (void)alertMsg:(NSString *)msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:msg message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
