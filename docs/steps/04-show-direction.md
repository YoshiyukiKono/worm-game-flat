# 04. 頭の向きを小円で表す

## 到達点

頭の円の内側に、進行方向を示す小円を描きます。

## 幾何

頭の半径を `R`、小円の半径を `r` とします。小円を頭の円周へ内接させるには、中心間の距離を `R - r` にします。

```gdscript
var marker_offset := direction * (head_radius - marker_radius)
draw_circle(head_center + marker_offset, marker_radius, marker_color)
```

## 確認

方向を変更すると、小円が頭の上下左右へ移動します。
