; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

define <4 x i16> @shuffle_v4i16(<4 x i16> %x, <4 x i16> %y) {
; CHECK-LABEL: shuffle_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 11
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> %y, <4 x i32> <i32 0, i32 1, i32 6, i32 3>
  ret <4 x i16> %s
}

define <8 x i32> @shuffle_v8i32(<8 x i32> %x, <8 x i32> %y) {
; CHECK-LABEL: shuffle_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 203
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %s = shufflevector <8 x i32> %x, <8 x i32> %y, <8 x i32> <i32 0, i32 1, i32 10, i32 3, i32 12, i32 13, i32 6, i32 7>
  ret <8 x i32> %s
}

define <4 x i16> @shuffle_xv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shuffle_xv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 9
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    vmerge.vim v8, v8, 5, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i16> %x, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x i16> %s
}

define <4 x i16> @shuffle_vx_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shuffle_vx_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a0, zero, 6
; CHECK-NEXT:    vsetivli a1, 1, e8,m1,ta,mu
; CHECK-NEXT:    vmv.s.x v0, a0
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    vmerge.vim v8, v8, 5, v0
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i32> <i32 0, i32 5, i32 6, i32 3>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_permute_shuffle_vu_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_permute_shuffle_vu_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    sh a0, 12(sp)
; CHECK-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    sh a0, 14(sp)
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vmv.x.s a1, v25
; CHECK-NEXT:    sh a1, 10(sp)
; CHECK-NEXT:    sh a0, 8(sp)
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    addi a0, sp, 8
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> undef, <4 x i32> <i32 1, i32 2, i32 0, i32 1>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_permute_shuffle_uv_v4i16(<4 x i16> %x) {
; CHECK-LABEL: vrgather_permute_shuffle_uv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    sh a0, 12(sp)
; CHECK-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v8, 1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    sh a0, 14(sp)
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vmv.x.s a1, v25
; CHECK-NEXT:    sh a1, 10(sp)
; CHECK-NEXT:    sh a0, 8(sp)
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    addi a0, sp, 8
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> undef, <4 x i16> %x, <4 x i32> <i32 5, i32 6, i32 4, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_vv_v4i16(<4 x i16> %x, <4 x i16> %y) {
; CHECK-LABEL: vrgather_shuffle_vv_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    sh a0, 12(sp)
; CHECK-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; CHECK-NEXT:    vslidedown.vi v25, v9, 1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    sh a0, 14(sp)
; CHECK-NEXT:    vslidedown.vi v25, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    sh a0, 10(sp)
; CHECK-NEXT:    vslidedown.vi v25, v8, 1
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    sh a0, 8(sp)
; CHECK-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; CHECK-NEXT:    addi a0, sp, 8
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> %y, <4 x i32> <i32 1, i32 2, i32 0, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_xv_v4i16(<4 x i16> %x) {
; RV32-LABEL: vrgather_shuffle_xv_v4i16:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    lui a0, 80
; RV32-NEXT:    addi a0, a0, 5
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; RV32-NEXT:    vslidedown.vi v25, v8, 1
; RV32-NEXT:    vmv.x.s a0, v25
; RV32-NEXT:    sh a0, 14(sp)
; RV32-NEXT:    vslidedown.vi v25, v8, 2
; RV32-NEXT:    vmv.x.s a0, v25
; RV32-NEXT:    sh a0, 12(sp)
; RV32-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vle16.v v8, (a0)
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_xv_v4i16:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    lui a0, 80
; RV64-NEXT:    addiw a0, a0, 5
; RV64-NEXT:    sw a0, 8(sp)
; RV64-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; RV64-NEXT:    vslidedown.vi v25, v8, 1
; RV64-NEXT:    vmv.x.s a0, v25
; RV64-NEXT:    sh a0, 14(sp)
; RV64-NEXT:    vslidedown.vi v25, v8, 2
; RV64-NEXT:    vmv.x.s a0, v25
; RV64-NEXT:    sh a0, 12(sp)
; RV64-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; RV64-NEXT:    addi a0, sp, 8
; RV64-NEXT:    vle16.v v8, (a0)
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
  %s = shufflevector <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i16> %x, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x i16> %s
}

define <4 x i16> @vrgather_shuffle_vx_v4i16(<4 x i16> %x) {
; RV32-LABEL: vrgather_shuffle_vx_v4i16:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    lui a0, 80
; RV32-NEXT:    addi a0, a0, 5
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    sh a0, 8(sp)
; RV32-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; RV32-NEXT:    vslidedown.vi v25, v8, 3
; RV32-NEXT:    vmv.x.s a0, v25
; RV32-NEXT:    sh a0, 10(sp)
; RV32-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vle16.v v8, (a0)
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vx_v4i16:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    .cfi_def_cfa_offset 16
; RV64-NEXT:    lui a0, 80
; RV64-NEXT:    addiw a0, a0, 5
; RV64-NEXT:    sw a0, 12(sp)
; RV64-NEXT:    vsetvli zero, zero, e16,m1,ta,mu
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    sh a0, 8(sp)
; RV64-NEXT:    vsetivli a0, 1, e16,m1,ta,mu
; RV64-NEXT:    vslidedown.vi v25, v8, 3
; RV64-NEXT:    vmv.x.s a0, v25
; RV64-NEXT:    sh a0, 10(sp)
; RV64-NEXT:    vsetivli a0, 4, e16,m1,ta,mu
; RV64-NEXT:    addi a0, sp, 8
; RV64-NEXT:    vle16.v v8, (a0)
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
  %s = shufflevector <4 x i16> %x, <4 x i16> <i16 5, i16 5, i16 5, i16 5>, <4 x i32> <i32 0, i32 3, i32 6, i32 5>
  ret <4 x i16> %s
}

define <8 x i64> @vrgather_permute_shuffle_vu_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_permute_shuffle_vu_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -128
; RV32-NEXT:    .cfi_def_cfa_offset 128
; RV32-NEXT:    sw ra, 124(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 120(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 128
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    sw a0, 48(sp)
; RV32-NEXT:    sw a0, 16(sp)
; RV32-NEXT:    vsetivli a0, 1, e32,m4,ta,mu
; RV32-NEXT:    vslidedown.vi v28, v8, 3
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 60(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 2
; RV32-NEXT:    vmv.x.s a1, v28
; RV32-NEXT:    sw a1, 56(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 1
; RV32-NEXT:    vmv.x.s a2, v28
; RV32-NEXT:    sw a2, 52(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 13
; RV32-NEXT:    vmv.x.s a3, v28
; RV32-NEXT:    sw a3, 44(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 12
; RV32-NEXT:    vmv.x.s a3, v28
; RV32-NEXT:    sw a3, 40(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 15
; RV32-NEXT:    vmv.x.s a3, v28
; RV32-NEXT:    sw a3, 36(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 14
; RV32-NEXT:    vmv.x.s a3, v28
; RV32-NEXT:    sw a3, 32(sp)
; RV32-NEXT:    sw a0, 28(sp)
; RV32-NEXT:    sw a1, 24(sp)
; RV32-NEXT:    sw a2, 20(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 5
; RV32-NEXT:    vmv.x.s a2, v28
; RV32-NEXT:    sw a2, 12(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 4
; RV32-NEXT:    vmv.x.s a2, v28
; RV32-NEXT:    sw a2, 8(sp)
; RV32-NEXT:    sw a0, 4(sp)
; RV32-NEXT:    sw a1, 0(sp)
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vle32.v v8, (sp)
; RV32-NEXT:    addi sp, s0, -128
; RV32-NEXT:    lw s0, 120(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 124(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 128
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_vu_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -128
; RV64-NEXT:    .cfi_def_cfa_offset 128
; RV64-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 128
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    sd a0, 48(sp)
; RV64-NEXT:    sd a0, 16(sp)
; RV64-NEXT:    vsetivli a0, 1, e64,m4,ta,mu
; RV64-NEXT:    vslidedown.vi v28, v8, 1
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 56(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 6
; RV64-NEXT:    vmv.x.s a1, v28
; RV64-NEXT:    sd a1, 40(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 7
; RV64-NEXT:    vmv.x.s a1, v28
; RV64-NEXT:    sd a1, 32(sp)
; RV64-NEXT:    sd a0, 24(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 2
; RV64-NEXT:    vmv.x.s a1, v28
; RV64-NEXT:    sd a1, 8(sp)
; RV64-NEXT:    sd a0, 0(sp)
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v8, (sp)
; RV64-NEXT:    addi sp, s0, -128
; RV64-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 128
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> undef, <8 x i32> <i32 1, i32 2, i32 0, i32 1, i32 7, i32 6, i32 0, i32 1>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_permute_shuffle_uv_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_permute_shuffle_uv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -128
; RV32-NEXT:    .cfi_def_cfa_offset 128
; RV32-NEXT:    sw ra, 124(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 120(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 128
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    sw a0, 48(sp)
; RV32-NEXT:    sw a0, 40(sp)
; RV32-NEXT:    sw a0, 16(sp)
; RV32-NEXT:    vsetivli a0, 1, e32,m4,ta,mu
; RV32-NEXT:    vslidedown.vi v28, v8, 7
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 60(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 6
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 56(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 1
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 52(sp)
; RV32-NEXT:    sw a0, 44(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 15
; RV32-NEXT:    vmv.x.s a1, v28
; RV32-NEXT:    sw a1, 36(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 14
; RV32-NEXT:    vmv.x.s a1, v28
; RV32-NEXT:    sw a1, 32(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 3
; RV32-NEXT:    vmv.x.s a1, v28
; RV32-NEXT:    sw a1, 28(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 2
; RV32-NEXT:    vmv.x.s a2, v28
; RV32-NEXT:    sw a2, 24(sp)
; RV32-NEXT:    sw a0, 20(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 5
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 4
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a1, 4(sp)
; RV32-NEXT:    sw a2, 0(sp)
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vle32.v v8, (sp)
; RV32-NEXT:    addi sp, s0, -128
; RV32-NEXT:    lw s0, 120(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 124(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 128
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_permute_shuffle_uv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -128
; RV64-NEXT:    .cfi_def_cfa_offset 128
; RV64-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 128
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    sd a0, 48(sp)
; RV64-NEXT:    sd a0, 40(sp)
; RV64-NEXT:    sd a0, 16(sp)
; RV64-NEXT:    vsetivli a0, 1, e64,m4,ta,mu
; RV64-NEXT:    vslidedown.vi v28, v8, 3
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 56(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 7
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 32(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 1
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 24(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 2
; RV64-NEXT:    vmv.x.s a1, v28
; RV64-NEXT:    sd a1, 8(sp)
; RV64-NEXT:    sd a0, 0(sp)
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v8, (sp)
; RV64-NEXT:    addi sp, s0, -128
; RV64-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 128
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> undef, <8 x i64> %x, <8 x i32> <i32 9, i32 10, i32 8, i32 9, i32 15, i32 8, i32 8, i32 11>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_vv_v8i64(<8 x i64> %x, <8 x i64> %y) {
; RV32-LABEL: vrgather_shuffle_vv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -128
; RV32-NEXT:    .cfi_def_cfa_offset 128
; RV32-NEXT:    sw ra, 124(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 120(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 128
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    vsetivli a0, 1, e32,m4,ta,mu
; RV32-NEXT:    vslidedown.vi v28, v12, 11
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 60(sp)
; RV32-NEXT:    vslidedown.vi v28, v12, 10
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 56(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 7
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 52(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 6
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 48(sp)
; RV32-NEXT:    vslidedown.vi v28, v12, 5
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 44(sp)
; RV32-NEXT:    vslidedown.vi v28, v12, 4
; RV32-NEXT:    vmv.x.s a1, v28
; RV32-NEXT:    sw a1, 40(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 3
; RV32-NEXT:    vmv.x.s a2, v28
; RV32-NEXT:    sw a2, 36(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 2
; RV32-NEXT:    vmv.x.s a3, v28
; RV32-NEXT:    sw a3, 32(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 11
; RV32-NEXT:    vmv.x.s a4, v28
; RV32-NEXT:    sw a4, 28(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 10
; RV32-NEXT:    vmv.x.s a4, v28
; RV32-NEXT:    sw a4, 24(sp)
; RV32-NEXT:    sw a0, 20(sp)
; RV32-NEXT:    sw a1, 16(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 5
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 4
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    sw a2, 4(sp)
; RV32-NEXT:    sw a3, 0(sp)
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vle32.v v8, (sp)
; RV32-NEXT:    addi sp, s0, -128
; RV32-NEXT:    lw s0, 120(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 124(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 128
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -128
; RV64-NEXT:    .cfi_def_cfa_offset 128
; RV64-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 128
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    vsetivli a0, 1, e64,m4,ta,mu
; RV64-NEXT:    vslidedown.vi v28, v12, 5
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 56(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 3
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 48(sp)
; RV64-NEXT:    vslidedown.vi v28, v12, 2
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 40(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 1
; RV64-NEXT:    vmv.x.s a1, v28
; RV64-NEXT:    sd a1, 32(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 5
; RV64-NEXT:    vmv.x.s a2, v28
; RV64-NEXT:    sd a2, 24(sp)
; RV64-NEXT:    sd a0, 16(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 2
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 8(sp)
; RV64-NEXT:    sd a1, 0(sp)
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v8, (sp)
; RV64-NEXT:    addi sp, s0, -128
; RV64-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 128
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> %y, <8 x i32> <i32 1, i32 2, i32 10, i32 5, i32 1, i32 10, i32 3, i32 13>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_xv_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_shuffle_xv_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -128
; RV32-NEXT:    .cfi_def_cfa_offset 128
; RV32-NEXT:    sw ra, 124(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 120(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 128
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    addi a0, zero, -1
; RV32-NEXT:    sw a0, 60(sp)
; RV32-NEXT:    sw a0, 56(sp)
; RV32-NEXT:    sw a0, 28(sp)
; RV32-NEXT:    sw a0, 24(sp)
; RV32-NEXT:    sw a0, 20(sp)
; RV32-NEXT:    sw a0, 16(sp)
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    sw a0, 32(sp)
; RV32-NEXT:    sw a0, 0(sp)
; RV32-NEXT:    vsetivli a0, 1, e32,m4,ta,mu
; RV32-NEXT:    vslidedown.vi v28, v8, 13
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 52(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 12
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 48(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 9
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 44(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 8
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 40(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 1
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 36(sp)
; RV32-NEXT:    sw a0, 4(sp)
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vle32.v v8, (sp)
; RV32-NEXT:    addi sp, s0, -128
; RV32-NEXT:    lw s0, 120(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 124(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 128
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_xv_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -128
; RV64-NEXT:    .cfi_def_cfa_offset 128
; RV64-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 128
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    addi a0, zero, -1
; RV64-NEXT:    sd a0, 56(sp)
; RV64-NEXT:    sd a0, 24(sp)
; RV64-NEXT:    sd a0, 16(sp)
; RV64-NEXT:    sd a0, 8(sp)
; RV64-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    sd a0, 32(sp)
; RV64-NEXT:    sd a0, 0(sp)
; RV64-NEXT:    vsetivli a0, 1, e64,m4,ta,mu
; RV64-NEXT:    vslidedown.vi v28, v8, 6
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 48(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 4
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 40(sp)
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v8, (sp)
; RV64-NEXT:    addi sp, s0, -128
; RV64-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 128
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> <i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1, i64 -1>, <8 x i64> %x, <8 x i32> <i32 8, i32 3, i32 6, i32 5, i32 8, i32 12, i32 14, i32 3>
  ret <8 x i64> %s
}

define <8 x i64> @vrgather_shuffle_vx_v8i64(<8 x i64> %x) {
; RV32-LABEL: vrgather_shuffle_vx_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -128
; RV32-NEXT:    .cfi_def_cfa_offset 128
; RV32-NEXT:    sw ra, 124(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 120(sp) # 4-byte Folded Spill
; RV32-NEXT:    .cfi_offset ra, -4
; RV32-NEXT:    .cfi_offset s0, -8
; RV32-NEXT:    addi s0, sp, 128
; RV32-NEXT:    .cfi_def_cfa s0, 0
; RV32-NEXT:    andi sp, sp, -64
; RV32-NEXT:    sw zero, 60(sp)
; RV32-NEXT:    addi a0, zero, 5
; RV32-NEXT:    sw a0, 56(sp)
; RV32-NEXT:    sw zero, 28(sp)
; RV32-NEXT:    sw a0, 24(sp)
; RV32-NEXT:    sw zero, 20(sp)
; RV32-NEXT:    sw a0, 16(sp)
; RV32-NEXT:    vsetvli zero, zero, e32,m4,ta,mu
; RV32-NEXT:    vmv.x.s a0, v8
; RV32-NEXT:    sw a0, 0(sp)
; RV32-NEXT:    vsetivli a0, 1, e32,m4,ta,mu
; RV32-NEXT:    vslidedown.vi v28, v8, 15
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 52(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 14
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 48(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 3
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 44(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 2
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 40(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 9
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 36(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 8
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 32(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 7
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 6
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    vslidedown.vi v28, v8, 1
; RV32-NEXT:    vmv.x.s a0, v28
; RV32-NEXT:    sw a0, 4(sp)
; RV32-NEXT:    vsetivli a0, 16, e32,m4,ta,mu
; RV32-NEXT:    vle32.v v8, (sp)
; RV32-NEXT:    addi sp, s0, -128
; RV32-NEXT:    lw s0, 120(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 124(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 128
; RV32-NEXT:    ret
;
; RV64-LABEL: vrgather_shuffle_vx_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -128
; RV64-NEXT:    .cfi_def_cfa_offset 128
; RV64-NEXT:    sd ra, 120(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 112(sp) # 8-byte Folded Spill
; RV64-NEXT:    .cfi_offset ra, -8
; RV64-NEXT:    .cfi_offset s0, -16
; RV64-NEXT:    addi s0, sp, 128
; RV64-NEXT:    .cfi_def_cfa s0, 0
; RV64-NEXT:    andi sp, sp, -64
; RV64-NEXT:    addi a0, zero, 5
; RV64-NEXT:    sd a0, 56(sp)
; RV64-NEXT:    sd a0, 24(sp)
; RV64-NEXT:    sd a0, 16(sp)
; RV64-NEXT:    vsetvli zero, zero, e64,m4,ta,mu
; RV64-NEXT:    vmv.x.s a0, v8
; RV64-NEXT:    sd a0, 0(sp)
; RV64-NEXT:    vsetivli a0, 1, e64,m4,ta,mu
; RV64-NEXT:    vslidedown.vi v28, v8, 7
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 48(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 1
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 40(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 4
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 32(sp)
; RV64-NEXT:    vslidedown.vi v28, v8, 3
; RV64-NEXT:    vmv.x.s a0, v28
; RV64-NEXT:    sd a0, 8(sp)
; RV64-NEXT:    vsetivli a0, 8, e64,m4,ta,mu
; RV64-NEXT:    vle64.v v8, (sp)
; RV64-NEXT:    addi sp, s0, -128
; RV64-NEXT:    ld s0, 112(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 120(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 128
; RV64-NEXT:    ret
  %s = shufflevector <8 x i64> %x, <8 x i64> <i64 5, i64 5, i64 5, i64 5, i64 5, i64 5, i64 5, i64 5>, <8 x i32> <i32 0, i32 3, i32 10, i32 9, i32 4, i32 1, i32 7, i32 14>
  ret <8 x i64> %s
}
