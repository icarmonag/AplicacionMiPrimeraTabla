//
//  cellMainTable.h
//  Mi Primera Tabla
//
//  Created by Ivan on 9/20/17.
//  Copyright © 2017 wondererApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cellMainTable : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UIView *showBioOnSelection;



@end
