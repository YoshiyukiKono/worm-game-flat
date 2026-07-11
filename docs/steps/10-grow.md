# 10. 餌を食べると伸びる

## 到達点

新しい頭の位置が餌と一致した場合、末尾を削除せずに体を一つ伸ばします。

```gdscript
worm.push_front(new_head)

if new_head == food:
    place_food()
else:
    worm.pop_back()
```

## 確認

通常移動では長さを維持し、餌を食べたときだけ一節増えます。

これで最小の Worm ゲームが完成します。
