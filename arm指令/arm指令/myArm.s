
// 声明一个代码段
.text
.global _test, _add, _sub


// 自己练习的
_test:

str x0, [x1]

// ldp 指令
//ldp w1, w2 [x1, #0x4]


// ldr 、ldur指令
//;ldr x1, [x0,#0x4]
//ldur x1, [x0,-#0x4]

//// bl指令(函数调用)
//testCode:
//mov x3, #0x2
//ret
//
//mov x1, #0x6
//mov x2, #0x7
//cmp x1, x2
//bl testCode
//mov x4, #0x4
//mov x5, #0x2



//// b指令加条件
//testCode:
//mov x3, #0x2
//ret
//
//mov x1, #0x6
//mov x2, #0x7
//cmp x1, x2
//bgt testCode
//mov x4, #0x8



//// b指令
//b testCode
//mov x0, #0x6
//testCode:
//mov x1, #0x7



// cmp 指令
//mov x0, #0x5
//mov x1, #0x7
//cmp x0, x1


// mov 函数
//mov x0, #0x8
//mov x1, #0x4

ret

// add 函数

_add:

add x0, x0, x1

ret

// sub 函数
_sub:

sub x0, x0, x1

ret
