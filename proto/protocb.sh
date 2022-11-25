#!/bin/bash
# Path to this plugin
PROTOC_GEN_TS_PATH="../node_modules/.bin/protoc-gen-ts"

# Path to the grpc_node_plugin
PROTOC_GEN_GRPC_PATH="../node_modules/grpc_tools_node_protoc_ts/bin/protoc-gen-ts"

# Directory to write generated code to (.js and .d.ts files)
OUT_DIR="../generated"

protoc \
    --plugin="protoc-gen-ts=${PROTOC_GEN_TS_PATH}" \
    --js_out="import_style=commonjs,binary:${OUT_DIR}" \
    --ts_out="service=grpc-node,mode=grpc-js:${OUT_DIR}" \
    test_message.proto
