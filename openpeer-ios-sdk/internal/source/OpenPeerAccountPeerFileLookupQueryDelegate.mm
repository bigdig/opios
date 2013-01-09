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


#import "OpenPeerAccountPeerFileLookupQueryDelegate.h"
#import "HOPProvisioningAccount_Internal.h"
#import "HOPProvisioningAccountPeerFileLookupQuery.h"
#import "HOPContact_Internal.h"
#import "OpenPeerStorageManager.h"


OpenPeerAccountPeerFileLookupQueryDelegate::OpenPeerAccountPeerFileLookupQueryDelegate(id<HOPProvisioningAccountPeerFileLookupQueryDelegate> inProvisioningAccountPeerFileLookupQueryDelegate)
{
    provisioningAccountPeerFileLookupQueryDelegate = inProvisioningAccountPeerFileLookupQueryDelegate;
}

boost::shared_ptr<OpenPeerAccountPeerFileLookupQueryDelegate> OpenPeerAccountPeerFileLookupQueryDelegate::create(id<HOPProvisioningAccountPeerFileLookupQueryDelegate> inProvisioningAccountPeerFileLookupQueryDelegate)
{
    return boost::shared_ptr<OpenPeerAccountPeerFileLookupQueryDelegate> (new OpenPeerAccountPeerFileLookupQueryDelegate(inProvisioningAccountPeerFileLookupQueryDelegate));
}

void OpenPeerAccountPeerFileLookupQueryDelegate::onAccountPeerFileLookupQueryComplete(IAccountPeerFileLookupQueryPtr query)
{
    NSAutoreleasePool* _pool = [[NSAutoreleasePool alloc] init];
    
    HOPProvisioningAccountPeerFileLookupQuery* hopQuery = [[HOPProvisioningAccount sharedProvisioningAccount] getProvisioningAccountPeerFileLookupQueryForUniqueId:[NSNumber numberWithUnsignedLong:query->getID()]];
    
    if([hopQuery isComplete] && [hopQuery didSucceed])
    {
        for (NSString* userId in [hopQuery getUserIDs])
        {
            HOPContact* contact = [[OpenPeerStorageManager sharedStorageManager] getContactForUserId:userId];
            if (contact)
            {
                NSString* peerFile = [hopQuery getPublicPeerFileString:userId];
                [contact createCoreContactWithPeerFile:peerFile];
            }
        }
    }
    
    [provisioningAccountPeerFileLookupQueryDelegate onAccountPeerFileLookupQueryComplete:hopQuery];
    
    [_pool release];
}