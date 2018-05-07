//
//  ASHFirstDetailCollectTableViewCell.h
//  AsHacker
//
//  Created by 陈涛 on 2017/9/29.
//  Copyright © 2017年 Sinanbell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASHFirstDetailCollectTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;

@end
