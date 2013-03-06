(* Match random bits with integers.
 * $Id: test_11_match_ints.ml 187 2012-01-17 12:39:09Z richard.wm.jones@gmail.com $
 *)

open Printf

let rec range a b =
  if a <= b then
    a :: range (a+1) b
  else
    []

let () =
  Random.self_init ();

  for len = 1 to 99 do
    for bitlen = 1 to 63 do
      (* Create a random string of ints. *)
      let expected =
	List.map (fun _ ->
		    Random.int64 (Int64.sub (Int64.shift_left 1L bitlen) 1L))
	  (range 0 (len-1)) in

      let bits = Bitstring.Buffer.create () in
      List.iter (fun i ->
		   Bitstring.construct_int64_be_unsigned bits i bitlen
		     (Failure "constructing string"))
	expected;
      let bits = Bitstring.Buffer.contents bits in

      (* Now read the bitstring as integers.
       * In each case check the result against what we generated ('expected').
       *)
      let actual =
	let rec loop bits =
	  bitmatch bits with
	  | { i : bitlen; rest : -1 : bitstring }
	      when Bitstring.bitstring_length rest = 0 -> [i]
	  | { i : bitlen; rest : -1 : bitstring } -> i :: loop rest
	  | { _ } ->
	      failwith (sprintf "loop failed with len = %d, bitlen = %d"
			  len bitlen)
	in
	loop bits in
      if actual <> expected then
	failwith (sprintf "match ints: failed on test, len = %d, bitlen = %d"
		    len bitlen)
    done
  done
