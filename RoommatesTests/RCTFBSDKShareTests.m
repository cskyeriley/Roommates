// Copyright (c) 2015-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <XCTest/XCTest.h>

#import "RCTAssert.h"
#import "RCTConvert+FBSDKSharingContent.h"
#import "RCTRedBox.h"
#import "RCTRootView.h"
#import "RCTUtils.h"

// These strings were generated by creating the corresponding models in JS and calling JSON.stringify(...)
static NSString *const RCTFBSDKTestLinkJSON = @"{\"contentType\":\"link\",\"contentURL\":\"https://facebook.com\",\"contentDescription\":\"Test description.\",\"contentTitle\":\"Test Title\",\"imageURL\":\"https://facebook.com/sweetimage.png\",\"peopleIDs\":[\"12345\",\"23456\"],\"placeID\":\"34567\",\"ref\":\"ref\"}";
static NSString *const RCTFBSDKTestPhotoJSON = @"{\"contentType\":\"photo\",\"photos\":[{\"imageURL\":\"plutoBack.png\",\"userGenerated\":true}],\"peopleIDs\":[\"12345\",\"23456\"],\"placeID\":\"34567\",\"ref\":\"ref\"}";
static NSString *const RCTFBSDKTestVideoJSON = @"{\"contentType\":\"video\",\"video\":{\"videoURL\":\"assets-library://asset/asset.mp4?id=0A955F0F-A40B-43D2-A183-6AF088D294ED&ext=mp4\"},\"peopleIDs\":[\"12345\",\"23456\"],\"placeID\":\"34567\",\"ref\":\"ref\"}";
static NSString *const RCTFBSDKTestOpenGraphJSON = @"{\"contentType\":\"open-graph\",\"action\":{\"_properties\":{\"og:objectOne\":{\"type\":\"open-graph-object\",\"value\":{\"_properties\":{\"og:stringOne\":{\"type\":\"string\",\"value\":\"stringOne\"},\"og:numberOne\":{\"type\":\"number\",\"value\":5},\"og:arrayOne\":{\"type\":\"array\",\"value\":[{\"type\":\"number\",\"value\":5},{\"type\":\"string\",\"value\":\"stringOne\"}]},\"og:photo\":{\"type\":\"photo\",\"value\":{\"imageURL\":\"plutoBack.png\",\"userGenerated\":true}},\"og:objectTwo\":{\"type\":\"open-graph-object\",\"value\":{\"_properties\":{\"og:stringTwo\":{\"type\":\"string\",\"value\":\"stringTwo\"},\"og:numberTwo\":{\"type\":\"number\",\"value\":7},\"og:arrayTwo\":{\"type\":\"array\",\"value\":[{\"type\":\"number\",\"value\":7},{\"type\":\"string\",\"value\":\"stringTwo\"}]}}}}}}}},\"actionType\":\"og.action\"},\"previewPropertyName\":\"og:objectOne\",\"peopleIDs\":[\"12345\",\"23456\"],\"placeID\":\"34567\",\"ref\":\"ref\"}";

@interface RCTFBSDKShareTests : XCTestCase

@end

@implementation RCTFBSDKShareTests

#pragma mark - Tests

- (void)testConvertLinkContent
{
  // Build up a native link content object
  FBSDKShareLinkContent *nativeLinkContent = BuildLinkContent();
  // Convert the equivalent JSON object to a native link content object
  FBSDKShareLinkContent *convertedLinkContent = [RCTConvert RCTFBSDKSharingContent:RCTJSONParse(RCTFBSDKTestLinkJSON, nil)];
  // Ensure that the two are identical
  XCTAssertEqualObjects(nativeLinkContent, convertedLinkContent);
}

- (void)testConvertPhotoContent
{
  // Build up a native photo content object
  FBSDKSharePhotoContent *nativePhotoContent = BuildPhotoContent();
  // Convert the equivalent JSON object to a native photo content object
  FBSDKSharePhotoContent *convertedPhotoContent = [RCTConvert RCTFBSDKSharingContent:RCTJSONParse(RCTFBSDKTestPhotoJSON, nil)];
  // Ensure that the two are identical
  XCTAssertEqualObjects(nativePhotoContent, convertedPhotoContent);
}

- (void)testConvertVideoContent
{
  // Build up a native video content object
  FBSDKShareVideoContent *nativeVideoContent = BuildVideoContent();
  // Convert the equivalent JSON object to a native video content object
  FBSDKShareVideoContent *convertedVideoContent = [RCTConvert RCTFBSDKSharingContent:RCTJSONParse(RCTFBSDKTestVideoJSON, nil)];
  // Ensure that the two are identical
  XCTAssertEqualObjects(nativeVideoContent, convertedVideoContent);
}

- (void)testConvertOpenGraphActionWithObject
{
  // Build up a native open graph content object
  FBSDKShareOpenGraphContent *nativeOpenGraphContent = BuildOpenGraphContent();
  // Convert the equivalent JSON object to a native open graph content object
  FBSDKShareOpenGraphContent *convertedOpenGraphContent = [RCTConvert RCTFBSDKSharingContent:RCTJSONParse(RCTFBSDKTestOpenGraphJSON, nil)];
  // Ensure that the two are identical
  XCTAssertEqualObjects(nativeOpenGraphContent, convertedOpenGraphContent);
}

#pragma mark - Helper Functions

static void AppendGenericContent(id<FBSDKSharingContent> content)
{
  content.peopleIDs = @[@"12345", @"23456"];
  content.placeID = @"34567";
  content.ref = @"ref";
}

static FBSDKShareLinkContent *BuildLinkContent()
{
  FBSDKShareLinkContent *nativeLinkContent = [[FBSDKShareLinkContent alloc] init];
  AppendGenericContent(nativeLinkContent);
  nativeLinkContent.contentURL = [NSURL URLWithString:@"https://facebook.com"];
  nativeLinkContent.contentTitle = @"Test Title";
  nativeLinkContent.contentDescription = @"Test description.";
  nativeLinkContent.imageURL = [NSURL URLWithString:@"https://facebook.com/sweetimage.png"];
  return nativeLinkContent;
}

static FBSDKSharePhoto *BuildPhoto()
{
  return [FBSDKSharePhoto photoWithImage:[UIImage imageNamed:@"plutoBack.png"] userGenerated:YES];
}

static FBSDKSharePhotoContent *BuildPhotoContent()
{
  FBSDKSharePhotoContent *nativePhotoContent = [[FBSDKSharePhotoContent alloc] init];
  AppendGenericContent(nativePhotoContent);
  FBSDKSharePhoto *nativePhoto = BuildPhoto();
  nativePhotoContent.photos = @[nativePhoto];
  return nativePhotoContent;
}

static FBSDKShareVideoContent *BuildVideoContent()
{
  FBSDKShareVideoContent *nativeVideoContent = [[FBSDKShareVideoContent alloc] init];
  AppendGenericContent(nativeVideoContent);
  FBSDKShareVideo *nativeVideo = [FBSDKShareVideo videoWithVideoURL:[NSURL URLWithString:@"assets-library://asset/asset.mp4?id=0A955F0F-A40B-43D2-A183-6AF088D294ED&ext=mp4"]];
  nativeVideoContent.video = nativeVideo;
  return nativeVideoContent;
}

static FBSDKShareOpenGraphContent *BuildOpenGraphContent()
{
  // Build up an open graph object
  FBSDKShareOpenGraphObject *nativeOpenGraphObject = [[FBSDKShareOpenGraphObject alloc] init];
  [nativeOpenGraphObject setString:@"stringOne" forKey:@"og:stringOne"];
  [nativeOpenGraphObject setNumber:@5 forKey:@"og:numberOne"];
  [nativeOpenGraphObject setArray:@[@5, @"stringOne"] forKey:@"og:arrayOne"];
  [nativeOpenGraphObject setPhoto:BuildPhoto() forKey:@"og:photo"];
  // Build another native open graph object to add to the first
  FBSDKShareOpenGraphObject *nativeOpenGraphObjectInner = [[FBSDKShareOpenGraphObject alloc] init];
  [nativeOpenGraphObjectInner setString:@"stringTwo" forKey:@"og:stringTwo"];
  [nativeOpenGraphObjectInner setNumber:@7 forKey:@"og:numberTwo"];
  [nativeOpenGraphObjectInner setArray:@[@7, @"stringTwo"] forKey:@"og:arrayTwo"];
  [nativeOpenGraphObject setObject:nativeOpenGraphObjectInner forKey:@"og:objectTwo"];
  // Build up a native open graph action
  FBSDKShareOpenGraphAction *nativeOpenGraphAction = [FBSDKShareOpenGraphAction actionWithType:@"og.action" object:nativeOpenGraphObject key:@"og:objectOne"];
  // Build up a native open graph content object
  FBSDKShareOpenGraphContent *nativeOpenGraphContent = [[FBSDKShareOpenGraphContent alloc] init];
  nativeOpenGraphContent.action = nativeOpenGraphAction;
  nativeOpenGraphContent.previewPropertyName = @"og:objectOne";
  AppendGenericContent(nativeOpenGraphContent);
  return nativeOpenGraphContent;
}

@end
