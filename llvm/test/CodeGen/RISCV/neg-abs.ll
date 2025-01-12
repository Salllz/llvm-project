; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV32I
; RUN: llc -mtriple=riscv32 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV32ZBB
; RUN: llc -mtriple=riscv32 -mattr=+experimental-zbt -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV32IBT
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV64I
; RUN: llc -mtriple=riscv64 -mattr=+zbb -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV64ZBB
; RUN: llc -mtriple=riscv64 -mattr=+experimental-zbt -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV64IBT

declare i32 @llvm.abs.i32(i32, i1 immarg)
declare i64 @llvm.abs.i64(i64, i1 immarg)

define i32 @neg_abs32(i32 %x) {
; RV32I-LABEL: neg_abs32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    sub a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: neg_abs32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    min a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32IBT-LABEL: neg_abs32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    srai a1, a0, 31
; RV32IBT-NEXT:    xor a0, a0, a1
; RV32IBT-NEXT:    sub a0, a1, a0
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: neg_abs32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    subw a0, a1, a0
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: neg_abs32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    sraiw a1, a0, 31
; RV64ZBB-NEXT:    xor a0, a0, a1
; RV64ZBB-NEXT:    subw a0, a1, a0
; RV64ZBB-NEXT:    ret
;
; RV64IBT-LABEL: neg_abs32:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    sraiw a1, a0, 31
; RV64IBT-NEXT:    xor a0, a0, a1
; RV64IBT-NEXT:    subw a0, a1, a0
; RV64IBT-NEXT:    ret
  %abs = tail call i32 @llvm.abs.i32(i32 %x, i1 true)
  %neg = sub nsw i32 0, %abs
  ret i32 %neg
}

define i32 @select_neg_abs32(i32 %x) {
; RV32I-LABEL: select_neg_abs32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a1, a0, 31
; RV32I-NEXT:    xor a0, a0, a1
; RV32I-NEXT:    sub a0, a1, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: select_neg_abs32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a1, a0
; RV32ZBB-NEXT:    min a0, a0, a1
; RV32ZBB-NEXT:    ret
;
; RV32IBT-LABEL: select_neg_abs32:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    srai a1, a0, 31
; RV32IBT-NEXT:    xor a0, a0, a1
; RV32IBT-NEXT:    sub a0, a1, a0
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: select_neg_abs32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sraiw a1, a0, 31
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    subw a0, a1, a0
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: select_neg_abs32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    sraiw a1, a0, 31
; RV64ZBB-NEXT:    xor a0, a0, a1
; RV64ZBB-NEXT:    subw a0, a1, a0
; RV64ZBB-NEXT:    ret
;
; RV64IBT-LABEL: select_neg_abs32:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    sraiw a1, a0, 31
; RV64IBT-NEXT:    xor a0, a0, a1
; RV64IBT-NEXT:    subw a0, a1, a0
; RV64IBT-NEXT:    ret
  %1 = icmp slt i32 %x, 0
  %2 = sub nsw i32 0, %x
  %3 = select i1 %1, i32 %x, i32 %2
  ret i32 %3
}

define i64 @neg_abs64(i64 %x) {
; RV32I-LABEL: neg_abs64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    xor a0, a0, a2
; RV32I-NEXT:    sltu a3, a2, a0
; RV32I-NEXT:    xor a1, a1, a2
; RV32I-NEXT:    sub a1, a2, a1
; RV32I-NEXT:    sub a1, a1, a3
; RV32I-NEXT:    sub a0, a2, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: neg_abs64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srai a2, a1, 31
; RV32ZBB-NEXT:    xor a0, a0, a2
; RV32ZBB-NEXT:    sltu a3, a2, a0
; RV32ZBB-NEXT:    xor a1, a1, a2
; RV32ZBB-NEXT:    sub a1, a2, a1
; RV32ZBB-NEXT:    sub a1, a1, a3
; RV32ZBB-NEXT:    sub a0, a2, a0
; RV32ZBB-NEXT:    ret
;
; RV32IBT-LABEL: neg_abs64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    srai a2, a1, 31
; RV32IBT-NEXT:    xor a0, a0, a2
; RV32IBT-NEXT:    sltu a3, a2, a0
; RV32IBT-NEXT:    xor a1, a1, a2
; RV32IBT-NEXT:    sub a1, a2, a1
; RV32IBT-NEXT:    sub a1, a1, a3
; RV32IBT-NEXT:    sub a0, a2, a0
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: neg_abs64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    sub a0, a1, a0
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: neg_abs64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a1, a0
; RV64ZBB-NEXT:    min a0, a0, a1
; RV64ZBB-NEXT:    ret
;
; RV64IBT-LABEL: neg_abs64:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    srai a1, a0, 63
; RV64IBT-NEXT:    xor a0, a0, a1
; RV64IBT-NEXT:    sub a0, a1, a0
; RV64IBT-NEXT:    ret
  %abs = tail call i64 @llvm.abs.i64(i64 %x, i1 true)
  %neg = sub nsw i64 0, %abs
  ret i64 %neg
}

define i64 @select_neg_abs64(i64 %x) {
; RV32I-LABEL: select_neg_abs64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a2, a1, 31
; RV32I-NEXT:    xor a0, a0, a2
; RV32I-NEXT:    sltu a3, a2, a0
; RV32I-NEXT:    xor a1, a1, a2
; RV32I-NEXT:    sub a1, a2, a1
; RV32I-NEXT:    sub a1, a1, a3
; RV32I-NEXT:    sub a0, a2, a0
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: select_neg_abs64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srai a2, a1, 31
; RV32ZBB-NEXT:    xor a0, a0, a2
; RV32ZBB-NEXT:    sltu a3, a2, a0
; RV32ZBB-NEXT:    xor a1, a1, a2
; RV32ZBB-NEXT:    sub a1, a2, a1
; RV32ZBB-NEXT:    sub a1, a1, a3
; RV32ZBB-NEXT:    sub a0, a2, a0
; RV32ZBB-NEXT:    ret
;
; RV32IBT-LABEL: select_neg_abs64:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    srai a2, a1, 31
; RV32IBT-NEXT:    xor a0, a0, a2
; RV32IBT-NEXT:    sltu a3, a2, a0
; RV32IBT-NEXT:    xor a1, a1, a2
; RV32IBT-NEXT:    sub a1, a2, a1
; RV32IBT-NEXT:    sub a1, a1, a3
; RV32IBT-NEXT:    sub a0, a2, a0
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: select_neg_abs64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srai a1, a0, 63
; RV64I-NEXT:    xor a0, a0, a1
; RV64I-NEXT:    sub a0, a1, a0
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: select_neg_abs64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a1, a0
; RV64ZBB-NEXT:    min a0, a0, a1
; RV64ZBB-NEXT:    ret
;
; RV64IBT-LABEL: select_neg_abs64:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    srai a1, a0, 63
; RV64IBT-NEXT:    xor a0, a0, a1
; RV64IBT-NEXT:    sub a0, a1, a0
; RV64IBT-NEXT:    ret
  %1 = icmp slt i64 %x, 0
  %2 = sub nsw i64 0, %x
  %3 = select i1 %1, i64 %x, i64 %2
  ret i64 %3
}

define i32 @neg_abs32_multiuse(i32 %x, i32* %y) {
; RV32I-LABEL: neg_abs32_multiuse:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a2, a0, 31
; RV32I-NEXT:    xor a3, a0, a2
; RV32I-NEXT:    sub a0, a2, a3
; RV32I-NEXT:    sub a2, a3, a2
; RV32I-NEXT:    sw a2, 0(a1)
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: neg_abs32_multiuse:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    neg a3, a0
; RV32ZBB-NEXT:    min a2, a0, a3
; RV32ZBB-NEXT:    max a0, a0, a3
; RV32ZBB-NEXT:    sw a0, 0(a1)
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    ret
;
; RV32IBT-LABEL: neg_abs32_multiuse:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    srai a2, a0, 31
; RV32IBT-NEXT:    xor a3, a0, a2
; RV32IBT-NEXT:    sub a0, a2, a3
; RV32IBT-NEXT:    sub a2, a3, a2
; RV32IBT-NEXT:    sw a2, 0(a1)
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: neg_abs32_multiuse:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sext.w a3, a0
; RV64I-NEXT:    sraiw a2, a0, 31
; RV64I-NEXT:    xor a4, a0, a2
; RV64I-NEXT:    subw a2, a2, a4
; RV64I-NEXT:    srai a3, a3, 63
; RV64I-NEXT:    xor a0, a0, a3
; RV64I-NEXT:    subw a0, a0, a3
; RV64I-NEXT:    sw a0, 0(a1)
; RV64I-NEXT:    mv a0, a2
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: neg_abs32_multiuse:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    sext.w a2, a0
; RV64ZBB-NEXT:    sraiw a3, a0, 31
; RV64ZBB-NEXT:    xor a0, a0, a3
; RV64ZBB-NEXT:    subw a0, a3, a0
; RV64ZBB-NEXT:    neg a3, a2
; RV64ZBB-NEXT:    max a2, a2, a3
; RV64ZBB-NEXT:    sw a2, 0(a1)
; RV64ZBB-NEXT:    ret
;
; RV64IBT-LABEL: neg_abs32_multiuse:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    sext.w a3, a0
; RV64IBT-NEXT:    sraiw a2, a0, 31
; RV64IBT-NEXT:    xor a4, a0, a2
; RV64IBT-NEXT:    subw a2, a2, a4
; RV64IBT-NEXT:    srai a3, a3, 63
; RV64IBT-NEXT:    xor a0, a0, a3
; RV64IBT-NEXT:    subw a0, a0, a3
; RV64IBT-NEXT:    sw a0, 0(a1)
; RV64IBT-NEXT:    mv a0, a2
; RV64IBT-NEXT:    ret
  %abs = tail call i32 @llvm.abs.i32(i32 %x, i1 true)
  store i32 %abs, i32* %y
  %neg = sub nsw i32 0, %abs
  ret i32 %neg
}

define i64 @neg_abs64_multiuse(i64 %x, i64* %y) {
; RV32I-LABEL: neg_abs64_multiuse:
; RV32I:       # %bb.0:
; RV32I-NEXT:    srai a4, a1, 31
; RV32I-NEXT:    xor a5, a0, a4
; RV32I-NEXT:    sltu a3, a4, a5
; RV32I-NEXT:    xor a6, a1, a4
; RV32I-NEXT:    sub a6, a4, a6
; RV32I-NEXT:    sub a3, a6, a3
; RV32I-NEXT:    sub a4, a4, a5
; RV32I-NEXT:    bgez a1, .LBB5_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    snez a5, a0
; RV32I-NEXT:    add a1, a1, a5
; RV32I-NEXT:    neg a1, a1
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:  .LBB5_2:
; RV32I-NEXT:    sw a0, 0(a2)
; RV32I-NEXT:    sw a1, 4(a2)
; RV32I-NEXT:    mv a0, a4
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:    ret
;
; RV32ZBB-LABEL: neg_abs64_multiuse:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    srai a4, a1, 31
; RV32ZBB-NEXT:    xor a5, a0, a4
; RV32ZBB-NEXT:    sltu a3, a4, a5
; RV32ZBB-NEXT:    xor a6, a1, a4
; RV32ZBB-NEXT:    sub a6, a4, a6
; RV32ZBB-NEXT:    sub a3, a6, a3
; RV32ZBB-NEXT:    sub a4, a4, a5
; RV32ZBB-NEXT:    bgez a1, .LBB5_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    snez a5, a0
; RV32ZBB-NEXT:    add a1, a1, a5
; RV32ZBB-NEXT:    neg a1, a1
; RV32ZBB-NEXT:    neg a0, a0
; RV32ZBB-NEXT:  .LBB5_2:
; RV32ZBB-NEXT:    sw a0, 0(a2)
; RV32ZBB-NEXT:    sw a1, 4(a2)
; RV32ZBB-NEXT:    mv a0, a4
; RV32ZBB-NEXT:    mv a1, a3
; RV32ZBB-NEXT:    ret
;
; RV32IBT-LABEL: neg_abs64_multiuse:
; RV32IBT:       # %bb.0:
; RV32IBT-NEXT:    srai a4, a1, 31
; RV32IBT-NEXT:    xor a5, a0, a4
; RV32IBT-NEXT:    sltu a3, a4, a5
; RV32IBT-NEXT:    xor a6, a1, a4
; RV32IBT-NEXT:    sub a6, a4, a6
; RV32IBT-NEXT:    sub a3, a6, a3
; RV32IBT-NEXT:    sub a4, a4, a5
; RV32IBT-NEXT:    snez a5, a0
; RV32IBT-NEXT:    add a5, a1, a5
; RV32IBT-NEXT:    neg a5, a5
; RV32IBT-NEXT:    slti a6, a1, 0
; RV32IBT-NEXT:    cmov a1, a6, a5, a1
; RV32IBT-NEXT:    neg a5, a0
; RV32IBT-NEXT:    cmov a0, a6, a5, a0
; RV32IBT-NEXT:    sw a0, 0(a2)
; RV32IBT-NEXT:    sw a1, 4(a2)
; RV32IBT-NEXT:    mv a0, a4
; RV32IBT-NEXT:    mv a1, a3
; RV32IBT-NEXT:    ret
;
; RV64I-LABEL: neg_abs64_multiuse:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srai a2, a0, 63
; RV64I-NEXT:    xor a3, a0, a2
; RV64I-NEXT:    sub a0, a2, a3
; RV64I-NEXT:    sub a2, a3, a2
; RV64I-NEXT:    sd a2, 0(a1)
; RV64I-NEXT:    ret
;
; RV64ZBB-LABEL: neg_abs64_multiuse:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    neg a3, a0
; RV64ZBB-NEXT:    min a2, a0, a3
; RV64ZBB-NEXT:    max a0, a0, a3
; RV64ZBB-NEXT:    sd a0, 0(a1)
; RV64ZBB-NEXT:    mv a0, a2
; RV64ZBB-NEXT:    ret
;
; RV64IBT-LABEL: neg_abs64_multiuse:
; RV64IBT:       # %bb.0:
; RV64IBT-NEXT:    srai a2, a0, 63
; RV64IBT-NEXT:    xor a3, a0, a2
; RV64IBT-NEXT:    sub a0, a2, a3
; RV64IBT-NEXT:    sub a2, a3, a2
; RV64IBT-NEXT:    sd a2, 0(a1)
; RV64IBT-NEXT:    ret
  %abs = tail call i64 @llvm.abs.i64(i64 %x, i1 true)
  store i64 %abs, i64* %y
  %neg = sub nsw i64 0, %abs
  ret i64 %neg
}

