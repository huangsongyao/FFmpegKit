//
//  HSYFFmpegTools.m
//  FFmpegKit
//
//  Created by anmin on 2019/11/19.
//

#import "HSYFFmpegTools.h"
#import <FFmpeg/FFmpeg.h>

@interface HSYFFmpegTools () {
    @private AVFormatContext *avformatContext;
    @private AVDictionary *options;
    @private AVCodecContext *avcodecContext;
    @private AVCodec *avcodec;
    @private AVPacket *avpacket;
    @private AVFrame *avframeYUV;
    @private AVFrame *avframeRGB;
    @private struct SwsContext *swsContext;
    @private uint8_t *buffer;
}

@end

@implementation HSYFFmpegTools

- (instancetype)initWithFilePath:(NSString *)filePath
{
    if (self = [super init]) {
        avformatContext = NULL;
        options = NULL;
        avcodecContext = NULL;
        avcodec = NULL;
        avpacket = NULL;
        avframeYUV = NULL;
        avframeRGB = NULL;
        swsContext = NULL;
        buffer = NULL;
        
        avdevice_register_all();
        const char *url = filePath.UTF8String;
        if (avformat_open_input(&avformatContext, url, NULL, NULL) != 0) {
            NSLog(@"打开视频文件失败");
        } else {
            if (avformat_find_stream_info(avformatContext, &(options)) < 0) {
                NSLog(@"找不到流信息");
            } else {
                av_dump_format(avformatContext, 0, url, 0);
                NSInteger stream = -1;
                for (NSInteger i = 0; i < avformatContext->nb_streams; i ++) {
                    if (avformatContext->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO) {
                        stream = i;
                        break;
                    }
                }
                if (stream == -1) {
                    NSLog(@"该视频没有找到视频流");
                } else {
                    avcodecContext = avcodec_alloc_context3(NULL);
                    if (avcodec_parameters_to_context(avcodecContext, avformatContext->streams[stream]->codecpar) < 0) {
                        NSLog(@"获取解析器上下文失败");
                    } else {
                        avcodec = avcodec_find_decoder(avcodecContext->codec_id);
                        if (avcodec == NULL) {
                            NSLog(@"不支持文件的解码格式");
                        } else {
                            if (avcodec_open2(avcodecContext, avcodec, &(options)) < 0) {
                                NSLog(@"打开解析器失败");
                            } else {
                                avframeYUV = av_frame_alloc();
                                avframeRGB = av_frame_alloc();
                                if (avframeRGB == NULL || avframeYUV == NULL) {
                                    NSLog(@"创建像素帧失败");
                                } else {
                                    NSInteger bufferByte = av_image_get_buffer_size(AV_PIX_FMT_RGB24, avcodecContext->width, avcodecContext->height, 1);
                                    buffer = (uint8_t *)av_malloc(bufferByte * sizeof(uint8_t));
                                    av_image_fill_arrays(avframeRGB->data, avframeRGB->linesize, buffer, AV_PIX_FMT_RGB24, avcodecContext->width, avcodecContext->height, 1);
                                    swsContext = sws_getContext(avcodecContext->width, avcodecContext->height, avcodecContext->pix_fmt, avcodecContext->width, avcodecContext->height, AV_PIX_FMT_RGB24, SWS_BILINEAR, NULL, NULL, NULL);
                                    avpacket = av_packet_alloc();
                                    static NSInteger counts = 0;
                                    while (av_read_frame(avformatContext, avpacket) >= 0) {
                                        if (avpacket->stream_index == stream) {
                                            NSInteger codec = avcodec_send_packet(avcodecContext, avpacket);
                                            if (codec >= 0) {
                                                codec = avcodec_receive_frame(avcodecContext, avframeYUV);
                                                if (codec != AVERROR_EOF) {
                                                    sws_scale(swsContext, (uint8_t const *const *)avframeYUV->data, avframeYUV->linesize, 0, avcodecContext->height, avframeRGB->data, avframeRGB->linesize);
                                                    counts ++;
                                                    NSLog(@"avframeRGB Counts = %@", @(counts));
                                                }
                                            }
                                        }
                                        av_packet_unref(avpacket);
                                    }
                                    av_free(buffer);
                                    av_packet_free(&(avpacket));
                                    av_frame_free(&(avframeYUV));
                                    av_frame_free(&(avframeRGB));
                                    avcodec_close(avcodecContext);
                                    avformat_free_context(avformatContext);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return self;
}


@end
