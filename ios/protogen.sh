#!/bin/bash
protoc ../../react-native-demo-api/proto/test_message.proto \
    --proto_path=../../react-native-demo-api/proto \
    --plugin=./protoc-gen-swift \
    --swift_opt=Visibility=Public \
    --swift_out=./models \
    --plugin=./protoc-gen-grpc-swift \
    --grpc-swift_opt=Visibility=Public \
    --grpc-swift_out=./models
