# HDU-jizu-RIJ_CPU
HDU2020年计组实验

单周期、哈弗结构、硬布线结构的RIJ型cpu设计

下载说明：

```
git init
git clone https://github.com/Abandon339/HDU-jizu-RIJ_CPU

或者直接右上方点击code，再选择Download zip
```

IP核使用了一个ROM用于指令存储，由于上板子时用IP核建立的数据存储器会有一个周期的延时（有能解决的人可以issues），所以妥协使用二维数组。
