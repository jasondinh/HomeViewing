//
//  TVIAudioSink.h
//  TwilioVideo
//
//  Copyright © 2017 Twilio, Inc. All rights reserved.
//

#import <CoreMedia/CoreMedia.h>

/**
 *  TVIAudioSink consumes raw audio content from a TVIAudioTrack.
 */
@protocol TVIAudioSink <NSObject>

/**
 *  @brief Render a single audio sample.
 *
 *  @discussion Samples are delivered in a CMSampleBuffer which fully describes the format and timings of the audio.
 *  Please note that many audio frames are contained within a single CMSampleBuffer.
 *  You should expect callbacks to be raised at presentation time with an interval of 10 milliseconds.
 *
 *  @param audioSample A CMSampleBufferRef which is being delivered to the sink. You should retain this if you need it
 *  outside of the scope of this method call.
 */
- (void)renderSample:(CMSampleBufferRef)audioSample;

@end

