# 01. 円を一つ描く

## 到達点

画面に一つの円を表示します。

## 使用する Godot の要素

- `Node2D`
- `_draw()`
- `draw_circle()`

```gdscript
func _draw() -> void:
    draw_circle(Vector2(100, 100), 12.0, Color.WHITE)
```

## 確認

画面の指定位置に円が一つ表示されます。
