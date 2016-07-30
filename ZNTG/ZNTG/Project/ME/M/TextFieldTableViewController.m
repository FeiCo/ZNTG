//
//  TextFieldTableViewController.m
//  testtest
//
//  Created by Peter Hu on 16/7/29.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TextFieldTableViewController.h"

// View的字体
#define PHTextViewFont [UIFont systemFontOfSize:18]
// Field的字体
#define PHTextFieldFont [UIFont systemFontOfSize:20]

@interface TextFieldTableController()<UITextViewDelegate>

@property(nonatomic,assign) BOOL isField;
@property(nonatomic,assign) NSInteger countLimit;
@property(nonatomic,weak)UITextView *textView;
@property(nonatomic,copy)NSString *maxString;
@property(nonatomic,copy)NSString *defaultString;

@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;

@property(nonatomic,assign)TextTableViewKeyBoardType keyBoardType;
@end

@implementation TextFieldTableController



+(instancetype)TextFieldControllerWithType:(TextTableViewStyle)style
                               defaultText:(NSString *)str
                              keyBoardType:(TextTableViewKeyBoardType)type
                              andWordLimit:(NSInteger)count {
    TextFieldTableController *controller = [[TextFieldTableController alloc]init];
   if(style == TextTableViewStyleField)
{
    controller.isField = YES;
}
else
{
  controller.isField = NO;
}
    [controller setHeightAndX];
    controller.defaultString = str;
    controller.countLimit = count;
    controller.keyBoardType = type;
    return controller;
}



-(void)setHeightAndX {
    CGFloat height;
    CGFloat x;
    if (_isField == YES) {
        x = 5;
        height = 40;
    }
    else
    {
        NSString *str = @"T";
        for (int i = 1; i<_countLimit; i++) {
            str = [str stringByAppendingString:@"T"];
        }
        CGSize textSize = [self sizeWithText:str font:PHTextViewFont maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT)];
        height = textSize.height + 60;
        x = 10;
    }
    _height = height;
    _x = x;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 10)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    [_textView becomeFirstResponder];
}


#pragma mark -TextView Delegate


-(void)textViewDidChange:(UITextView *)textView {
    
    NSString *str = textView.text;
    if(str.length == _countLimit)
    {
        _maxString = textView.text;
        NSLog(@"%@",textView.text);
    }
    if(str.length > _countLimit)
    {
        textView.text = _maxString;
    }
    
}



- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(_x, 0, [UIScreen mainScreen].bounds.size.width - 2 * _x, _height)];
    if (_isField == YES) {
        textView.font = PHTextFieldFont;
    }
    else
    {
        textView.font = PHTextViewFont;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    [cell.contentView addSubview:textView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    textView.delegate = self;
    textView.text = _defaultString;
    if (_keyBoardType == TextTableViewKeyBoardTypeNumber) {
        textView.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    textView.returnKeyType = UIReturnKeyDone;
    _textView = textView;
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _height;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
