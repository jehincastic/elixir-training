defmodule Kv.BucketTest do
  use ExUnit.Case, async: true

  # Setup will be called before test
  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "stroes value by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)

    assert KV.Bucket.get(bucket, "milk") == 3

    assert KV.Bucket.delete(bucket, "milk") == 3

    assert KV.Bucket.get(bucket, "milk") == nil

    assert KV.Bucket.delete(bucket, "milk") == nil
  end
end
