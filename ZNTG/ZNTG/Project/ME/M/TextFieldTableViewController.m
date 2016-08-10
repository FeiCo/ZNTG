//
//  TextFieldTableViewController.m
//  testtest
//
//  Created by Peter Hu on 16/7/29.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "TextFieldTableViewController.h"
#import "MJProvince.h"

// View的字体
#define PHTextViewFont [UIFont systemFontOfSize:18]
// Field的字体
#define PHTextFieldFont [UIFont systemFontOfSize:20]

@interface TextFieldTableController()<UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *_provinces;
}


@property(nonatomic,copy) NSString * id;
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


-(void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault setValue:_textView.text forKey:_id];
}


+(instancetype)TextFieldControllerWithType:(TextTableViewStyle)style
                               defaultText:(NSString *)str
                              keyBoardType:(TextTableViewKeyBoardType)type
                              andWordLimit:(NSInteger)count andIdentifier:(NSString *)id {
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
    controller.id = id;
    return controller;
}



-(void)setAdressPicker{
    
    // 1.初始化模型数据
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil]];
    
    _provinces = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        MJProvince *p = [MJProvince provinceWithDict:dict];
        [_provinces addObject:p];
    }
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
//    [self pickerView:nil didSelectRow:0 inComponent:0];
    _textView.inputView = pickerView;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

#pragma mark 第component列有多少行数据
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) { // 多少个省份
        return _provinces.count;
    } else { // 当前选中省份的行数（城市个数）
        // 1.获得选中了哪一个省
        int pIndex = [pickerView selectedRowInComponent:0];
        
        // 2.取出省份模型
        MJProvince *p = _provinces[pIndex];
        
        // 3.返回当前省份城市的个数
        return p.cities.count;
    }
}

#pragma mark - 代理
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) { //显示哪个省份
        // 1.取出省份模型
        MJProvince *p = _provinces[row];
        
        // 2.取出省份名称
        return p.name;
    } else { // 显示哪个城市
        // 1.获得选中了哪一个省
        int pIndex = [pickerView selectedRowInComponent:0];
        
        // 2.取出省份模型
        MJProvince *p = _provinces[pIndex];
        
        // 3.返回对应行的城市名称
        return p.cities[row];
    }
}

#pragma mark 监听选中了某一列的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { // 改变了省份
        // 刷新第1列的数据(重新刷新数据，重新调用数据源和代理的相应方法获得数据)
        [pickerView reloadComponent:1];
        
        // 选中第1列的第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    
    // 更改文字
    // 1.获得选中的省份名称
    int pIndex =  [pickerView selectedRowInComponent:0];
    MJProvince *p = _provinces[pIndex];
    
    // 2.获得选中的城市位置
    int cIndex = [pickerView selectedRowInComponent:1];
    _textView.text = [NSString stringWithFormat:@"%@ %@", p.name, p.cities[cIndex]];
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
    textView.returnKeyType = UIReturnKeyDone;
    _textView = textView;
    if (_keyBoardType == TextTableViewKeyBoardTypeNumber) {
        textView.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if (_keyBoardType == TextTableViewKeyBoardTypeAdreessPicker)
    {
       [self setAdressPicker];
    }
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
