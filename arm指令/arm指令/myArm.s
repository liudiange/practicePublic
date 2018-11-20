
// 声明一个代码段
.text
.global _test, _add, _sub


// 自己练习的
_test:

// b指令
b testCode
mov x0, #0x6
testCode:
mov x1, #0x7



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
