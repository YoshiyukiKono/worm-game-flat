# 07. hjkl で方向を変更する

## 到達点

Vim と同じ配置で進行方向を変更します。

```text
    k
h       l
    j
```

## Input Map

| Action | Key |
|---|---|
| `move_left` | `h` |
| `move_down` | `j` |
| `move_up` | `k` |
| `move_right` | `l` |

真後ろへ折り返す入力は無視します。

```gdscript
if requested + direction != Vector2i.ZERO:
    pending_direction = requested
```

## 確認

直角方向へ曲がれますが、現在の進行方向と反対方向へは曲がりません。
