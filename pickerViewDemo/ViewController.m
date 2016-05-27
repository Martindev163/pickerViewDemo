//
//  ViewController.m
//  pickerViewDemo
//
//  Created by 马浩哲 on 16/5/27.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "ViewController.h"
#import "cityModel.h"
#import "provinceModel.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (assign, nonatomic) NSInteger selectProvicneIndex;

@property (assign, nonatomic) NSInteger selectCityIndex;

@property (strong, nonatomic) NSArray *provinceAr;
@property (strong, nonatomic) NSArray *cityAr;
@property (strong, nonatomic) NSArray *districtAr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectCityIndex = 0;
    _selectProvicneIndex = 0;
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource =self;
    
    _provinceAr = [[NSArray alloc] init];
    _cityAr = [[NSArray alloc] init];
    _districtAr = [[NSArray alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    [self getPickerData];
}

#pragma mark - loadData
/*此处是
 [
   {省
     [
       {市
          [县]
       }
     ]
   }
 ]*/
//也可能遇到是字典开始的，只要将数据解析出来就好
-(void)getPickerData
{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"testList" ofType:@"plist"];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:dataPath];
    
    //将省市县各级数据都用数组单独存起来（每个数组中都是string）
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in arr) {
        provinceModel *procinceMd = [[provinceModel alloc] init];
        [procinceMd loadCitysWithDictionary:dic];
        [_dataArray addObject:procinceMd];
        [provinceArray addObject:procinceMd.province];
    }
    _provinceAr = provinceArray;//省（string集合）
   
    provinceModel *procinceMd = [[provinceModel alloc] init];
    procinceMd = _dataArray[0];
    cityModel *cityMd = [[cityModel alloc] init];
    cityMd = procinceMd.cityMd;
    
    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<procinceMd.cityArray.count; i++) {
        [cityArray addObject:cityMd.city];
    }
    _cityAr = cityArray;//市
    
    NSArray *districtArray = [[NSArray alloc] init];
    districtArray = cityMd.districtArr;
    _districtAr = districtArray;//县
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _provinceAr.count;
    }
    else if (component == 1)
    {
        return _cityAr.count;
    }else
    {
        return _districtAr.count;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return _provinceAr[row];
    }else if (component == 1)
    {
        return _cityAr[row];
    }else
    {
        return _districtAr[row];
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    provinceModel *procinceMd = [[provinceModel alloc] init];
    procinceMd = _dataArray[row];
    cityModel *cityMd = [[cityModel alloc] init];
    
    if (component == 0) {
        NSMutableArray *cityArray = [[NSMutableArray alloc] init];
        for (cityModel *cMd in procinceMd.cityArray) {
            [cityArray addObject:cMd.city];
        }
        _cityAr = cityArray;
        cityMd = procinceMd.cityArray[0] ;
        _districtAr = cityMd.districtArr;
        
        _selectProvicneIndex = row;
        NSLog(@"%@",[NSNumber numberWithInteger:_selectProvicneIndex]);
    }
    else if (component == 1)
    {
        procinceMd = _dataArray[_selectProvicneIndex];
        cityMd = procinceMd.cityArray[row];
        _districtAr = cityMd.districtArr;
    }
    [self.pickerView reloadAllComponents];
}

@end
