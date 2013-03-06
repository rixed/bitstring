(* Test check() and bind().
 * $Id: test_70_check_and_bind.ml 187 2012-01-17 12:39:09Z richard.wm.jones@gmail.com $
 *)

open Printf
open Bitstring

let bits = (BITSTRING { 101 : 16; 202 : 16 })

let () =
  bitmatch bits with
  | { i : 16 : check (i = 101), bind (i*4);
      j : 16 : check (j = 202) } ->
      if i <> 404 || j <> 202 then
	failwith (sprintf "70_check_and_bind: failed: %d %d" i j)
  | { _ } ->
      failwith "70_check_and_bind: match failed"
