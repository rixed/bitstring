(* Open a persistent pattern
 * $Id: test_51_open_pattern.ml 187 2012-01-17 12:39:09Z richard.wm.jones@gmail.com $
 *)

open Printf
open Bitstring

open bitmatch "tests/test.bmpp"

let () =
  let bits = bitstring_of_string "\022Mary had a little lamb" in
  bitmatch bits with
  | { :pascal_string } ->
      () (*printf "it's a Pascal string, len = %d, string = %S\n" len str*)
  | { _ } ->
      eprintf "not matching error\n";
      exit 1
