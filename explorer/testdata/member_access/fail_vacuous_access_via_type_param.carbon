// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// RUN: %{not} %{explorer} %s 2>&1 | \
// RUN:   %{FileCheck} --match-full-lines --allow-unused-prefixes=false %s
// RUN: %{not} %{explorer} --parser_debug --trace_file=- %s 2>&1 | \
// RUN:   %{FileCheck} --match-full-lines --allow-unused-prefixes %s
// AUTOUPDATE: %{explorer} %s

package Foo api;
interface A { fn F() -> i32; }
class X {
  impl as A {
    fn F() -> i32 { return 1; }
  }
}
fn F[T:! A](a: T) -> i32 {
  // CHECK: COMPILATION ERROR: {{.*}}/explorer/testdata/member_access/fail_vacuous_access_via_type_param.carbon:[[@LINE+1]]: expected name of instance member or interface member in compound member access, found fn () -> i32
  return a.(T.F)();
}
fn Main() -> i32 {
  var a: X = {};
  return F(a);
}
