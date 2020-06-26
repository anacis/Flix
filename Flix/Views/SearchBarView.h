//
//  SearchBarViewCollectionReusableView.h
//  Flix
//
//  Created by Ana Cismaru on 6/25/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchBarView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END
