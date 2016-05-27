//
//  provinceModel.h
//  PullDownMenuDemo
//
//  Created by 马浩哲 on 16/5/26.
//  Copyright © 2016年 MHZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class cityModel;
@interface provinceModel : NSObject

@property (nonatomic, copy) NSString *province;

@property (strong, nonatomic) NSArray *cityArray;

@property (strong, nonatomic) cityModel *cityMd;

-(instancetype)loadCitysWithDictionary:(NSDictionary *)cityDictionary;
@end
