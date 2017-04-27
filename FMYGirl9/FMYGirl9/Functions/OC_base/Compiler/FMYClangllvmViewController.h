//
//  FMYClangllvmViewController.h
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/27.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYTableViewController.h"



#if foo
#endif foo // warning: extra tokens at end of #endif directive

//#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra-tokens"

#if foo
#endif foo // no warning

#pragma clang diagnostic pop




// The following will produce warning messages
#pragma message "some diagnostic message"
#pragma GCC warning "TODO: replace deprecated feature"

// The following will produce an error message
//#pragma GCC error "Not supported"


@interface FMYClangllvmViewController : FMYTableViewController

@end
