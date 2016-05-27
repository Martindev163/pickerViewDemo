//
//  provinceModel.m
//  PullDownMenuDemo
//
//  Created by 马浩哲 on 16/5/26.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import "provinceModel.h"

#import "cityModel.h"

@interface provinceModel ()

@end

@implementation provinceModel


-(instancetype)loadCitysWithDictionary:(NSDictionary *)cityDictionary
{
    self.province = cityDictionary[@"province"];
    
    self.cityArray = cityDictionary[@"city"];
    
    NSMutableArray *cityArr = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in self.cityArray)
    {
        self.cityMd = [[cityModel alloc] init];
        
        self.cityMd.city = dic[@"city"];
        
        self.cityMd.districtArr =  dic[@"district"];
        
        [cityArr addObject:self.cityMd];
    }
    
    self.cityArray = cityArr;
    
    return self;
}

@end
