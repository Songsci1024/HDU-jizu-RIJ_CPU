- categories: ["Project"]
- tags: ["OS", "Lab", "HDU", "project"]
- keywords: ["杭电","杭州电子科技大学","HDU","操作系统实验","操作系统","实验","Linux","内核编译","进程管理"]
- alias: ["杭电操作系统实验", "HDU操作系统实验", "HDU操作系统"]
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

vivado用户可以直接运行，ISE用户可以到`RIJ_CPU\RIJ_CPU.srcs`目录下查看源码，constrs_1 - 约束文件， sim_1 - 仿真文件， source_1 - 设计design文件
