# 02. N × N の円を描く

## 到達点

画面全体を、等間隔に並んだ円で構成します。

## 考え方

二重ループでグリッド座標を列挙し、各セルの中心を画面座標へ変換します。

```gdscript
for y in range(GRID_SIZE):
    for x in range(GRID_SIZE):
        draw_circle(cell_center(Vector2i(x, y)), radius, ground_color)
```

## 確認

行数と列数が同じ円のグリッドが表示されます。
