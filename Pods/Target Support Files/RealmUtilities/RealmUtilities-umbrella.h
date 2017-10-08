#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RLMArray+Utilities.h"
#import "RLMObject+Utilities.h"
#import "RLMObjectBase+Utilities.h"

FOUNDATION_EXPORT double RealmUtilitiesVersionNumber;
FOUNDATION_EXPORT const unsigned char RealmUtilitiesVersionString[];

