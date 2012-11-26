/*
 
 Copyright (c) 2012, SMB Phone Inc.
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those
 of the authors and should not be interpreted as representing official policies,
 either expressed or implied, of the FreeBSD Project.
 
 */


#import <Foundation/Foundation.h>

@class HOPIdentity;
@class HOPLookupProfileInfo;

@interface HOPProvisioningAccountIdentityLookupQuery : NSObject

/**
 Check if identity lookup query is completed.
 @return YES if completed, NO if not
 */
- (BOOL) isComplete;

/**
 Check if identity lookup query was successful.
 @return YES if succeeded, NO if not
 */
- (BOOL) didSucceed;

/**
 Cancel the identity lookup query.
 */
- (void) cancel;

/**
 Retrieve lookup identities.
 @param outIdentites NSArray List of identities
 */
- (void) getIdentities: (NSArray*) outIdentities;

/**
 Perform lookup for provided identity.
 @param inIdentity HOPIdentity Identity for lookup
 @param outInfo HOPLookupProfileInfo Lookup result
 @return YES for lookup success, NO for failure
 */
- (BOOL) getLookupProfile: (HOPIdentity*) inIdentity outInfo: (HOPLookupProfileInfo*) outInfo;

@end
