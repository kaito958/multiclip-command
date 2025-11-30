#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
# Copyright (c) 2025 Kubota Kaito


set -eu

# テスト1: 基本的な保存と読み出し
echo "hello" | ./multiclip 1
result=$(./multiclip --load 1)
if [ "$result" != "hello" ]; then
  echo "test1 failed: expected 'hello', got '$result'" >&2
  exit 1
fi

# テスト2: 別スロットに保存しても干渉しない
echo "world" | ./multiclip 2
r1=$(./multiclip --load 1)
r2=$(./multiclip --load 2)
if [ "$r1" != "hello" ] || [ "$r2" != "world" ]; then
  echo "test2 failed: slots interfere" >&2
  exit 1
fi

# テスト3: 無効なスロット番号でエラーになるか
if ./multiclip 10 2>/dev/null; then
  echo "test3 failed: invalid slot accepted" >&2
  exit 1
fi

echo "all tests passed"
