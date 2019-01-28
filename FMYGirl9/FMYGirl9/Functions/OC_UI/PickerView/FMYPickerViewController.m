//
//  FMYPickerViewController.m
//  FMYGirl9
//
//  Created by lxw on 2017/10/20.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYPickerViewController.h"

@interface FMYPickerViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imgPickerController;
@end

@implementation FMYPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.arrDataSource addObjectsFromArray:@[@"UIImageViewPickerView",
                                              @"DataPickerView"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        [self.navigationController presentViewController:self.imgPickerController animated:YES completion:^{
            
        }];
    }
    else if (indexPath.row == 1)
    {
    }
    else if (indexPath.row == 2)
    {
    }
    else{
        
    }
}
/**
 *  The app's Info.plist must contain an NSPhotoLibraryUsageDescription key with a string value explaining to the user how the app uses this data.
 *
 *  @return 
 */
- (UIImagePickerController *)imgPickerController {
    if (!_imgPickerController) {
        _imgPickerController = [[UIImagePickerController alloc] init];
        _imgPickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imgPickerController.delegate = self;
        _imgPickerController.allowsEditing = YES;
    }
    return _imgPickerController;
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0);
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"%@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end








