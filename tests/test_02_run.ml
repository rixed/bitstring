(* Just check that we can run some functions from the library.
 * $Id: test_02_run.ml 187 2012-01-17 12:39:09Z richard.wm.jones@gmail.com $
 *)

let () =
  let bits = Bitstring.create_bitstring 16 in
  ignore (Bitstring.string_of_bitstring bits)
