; ModuleID = 'bpftrace'
source_filename = "bpftrace"
target datalayout = "e-m:e-p:64:64-i64:64-n32:64-S128"
target triple = "bpf-pc-linux"

%usym_t = type { i64, i64 }

; Function Attrs: nounwind
declare i64 @llvm.bpf.pseudo(i64, i64) #0

define i64 @"uprobe:/bin/sh:f"(i8*) local_unnamed_addr section "s_uprobe:/bin/sh:f_1" {
entry:
  %"@x_key" = alloca i64, align 8
  %usym = alloca %usym_t, align 8
  %1 = getelementptr i8, i8* %0, i64 128
  %2 = bitcast i8* %1 to i64*
  %func = load volatile i64, i64* %2, align 8
  %3 = bitcast %usym_t* %usym to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* nonnull %3)
  %get_pid_tgid = tail call i64 inttoptr (i64 14 to i64 ()*)()
  %4 = lshr i64 %get_pid_tgid, 32
  %5 = getelementptr inbounds %usym_t, %usym_t* %usym, i64 0, i32 0
  %6 = getelementptr inbounds %usym_t, %usym_t* %usym, i64 0, i32 1
  store i64 %func, i64* %5, align 8
  store i64 %4, i64* %6, align 8
  %7 = bitcast i64* %"@x_key" to i8*
  call void @llvm.lifetime.start.p0i8(i64 -1, i8* nonnull %7)
  store i64 0, i64* %"@x_key", align 8
  %pseudo = tail call i64 @llvm.bpf.pseudo(i64 1, i64 1)
  %update_elem = call i64 inttoptr (i64 2 to i64 (i64, i64*, %usym_t*, i64)*)(i64 %pseudo, i64* nonnull %"@x_key", %usym_t* nonnull %usym, i64 0)
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* nonnull %7)
  call void @llvm.lifetime.end.p0i8(i64 -1, i8* nonnull %3)
  ret i64 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #1

attributes #0 = { nounwind }
attributes #1 = { argmemonly nounwind }
