(* This code was written by Martin Lange as part of the CFGAnalyzer tool, *)
(* available at http://www2.tcs.ifi.lmu.de/~mlange/cfganalyzer/ *)
(* This version has been slightly modified by Jessica Sorrell for the *)
(* purposes of integrating the PicoSAT solver. *)

type picosat_solver 


type clause = int array

external picosat_InitManager : unit -> picosat_solver = "picosat_InitManager"

external picosat_ReleaseManager : picosat_solver -> unit = "picosat_ReleaseManager"

external picosat_SetNumVariables : picosat_solver -> int -> unit = "picosat_SetNumVariables"

external picosat_AddVariable : picosat_solver -> int = "picosat_AddVariable"

(*
external picosat_EnableVarBranch : picosat_solver -> int -> unit = "picosat_EnableVarBranch"

external picosat_DisableVarBranch : picosat_solver -> int -> unit = "picosat_DisableVarBranch"
*)

external picosat_AddClause : picosat_solver -> clause -> int -> unit = "picosat_AddClause"

external picosat_DeleteClauseGroup : picosat_solver -> int -> unit = "picosat_DeleteClauseGroup"

external picosat_Reset : picosat_solver -> unit = "picosat_Reset"

(*
external picosat_MergeClauseGroup : picosat_solver -> int -> int -> int = "picosat_MergeClauseGroup"
*)

external picosat_AllocClauseGroupID : picosat_solver -> int = "picosat_AllocClauseGroupID"

(*
external picosat_IsSetClauseGroupID : picosat_solver -> int -> int -> int = "picosat_IsSetClauseGroupID"

external picosat_SetClauseGroupID : picosat_solver -> int -> int = "picosat_SetClauseGroupID"

external picosat_ClearClauseGroupID : picosat_solver -> int -> int = "picosat_ClearClauseGroupID"

external picosat_GetVolatileGroupID : picosat_solver -> int = "picosat_GetVolatileGroupID"

external picosat_GlobalGroupID : picosat_solver -> int = "picosat_GetGlobalGroupID"
*)

external picosat_SetTimeLimit : picosat_solver -> float -> unit = "picosat_SetTimeLimit"
(*
external picosat_SetMemLimit : picosat_solver -> int -> unit = "picosat_SetMemLimit"
*)

external picosat_GetVarAsgnment : picosat_solver -> int -> int = "picosat_GetVarAsgnment"

external picosat_Solve : picosat_solver -> int = "picosat_Solve"

(*
external picosat_SetRandomness : picosat_solver -> int -> unit = "picosat_SetRandomness"

external picosat_SetRandSeed : picosat_solver -> int -> unit = "picosat_SetRandSeed"

external picosat_MakeDecision : picosat_solver -> int -> int -> unit = "picosat_MakeDecision"

external picosat_EstimateMemUsage : picosat_solver -> int = "picosat_EstimateMemUsage"

external picosat_GetElapseCPUTime : picosat_solver -> float = "picosat_GetElapseCPUTime"

external picosat_GetCurrentCPUTime : picosat_solver -> float = "picosat_GetCurrentCPUTime"

external picosat_GetCPUTime: picosat_solver -> float = "picosat_GetCPUTime"
*)

external picosat_NumLiterals : picosat_solver -> int = "picosat_NumLiterals"

external picosat_NumClauses : picosat_solver -> int = "picosat_NumClauses"

external picosat_NumVariables : picosat_solver -> int = "picosat_NumVariables"

(*
external picosat_InitNumLiterals : picosat_solver -> int64 = "picosat_InitNumLiterals"

external picosat_InitNumClauses : picosat_solver -> int = "picosat_InitNumClauses"

external picosat_NumAddedLiterals : picosat_solver -> int64 = "picosat_NumAddedLiterals"

external picosat_NumAddedClauses : picosat_solver -> int = "picosat_NumAddedClauses"

external picosat_NumDeletedClauses : picosat_solver -> int = "picosat_NumDeletedClauses"

external picosat_NumDecisions : picosat_solver -> int = "picosat_NumDecisions"

external picosat_NumImplications : picosat_solver -> int64 = "picosat_NumImplications"

external picosat_MaxDLevel : picosat_solver -> int = "picosat_MaxDLevel"

external picosat_AverageBubbleMove : picosat_solver -> float = "picosat_AverageBubbleMove"

external picosat_GetFirstClause : picosat_solver -> int = "picosat_GetFirstClause"
*)

(* This function does not work properly *)

(*
external picosat_GetClauseLits : picosat_solver -> int -> int -> unit = "picosat_GetClauseLits"
*)

(*-----------------------------------*)

(*
external picosat_EnableConfClsDeletion : picosat_solver -> unit = "picosat_EnableConfClsDeletion"

external picosat_DisableConfClsDeletion : picosat_solver -> unit = "picosat_DisableConfClsDeletion"

external picosat_SetClsDeletionInterval : picosat_solver -> int -> unit = "picosat_SetClsDeletionInterval"

external picosat_SetMaxUnrelevance : picosat_solver -> int -> unit = "picosat_SetMaxUnrelevance"

external picosat_SetMinClsLenForDelete : picosat_solver -> int -> unit = "picosat_SetMinClsLenForDelete"

external picosat_SetMaxConfClsLenAllowed : picosat_solver -> int -> unit = "picosat_SetMaxConfClsLenAllowed"
*)

(*********** The following are  Helper functions **************)

(*
external picosat_ReadCnf : picosat_solver -> string -> unit = "picosat_ReadCnf"

external picosat_HandleResult: picosat_solver -> int -> string -> unit = "picosat_HandleResult"

external picosat_OutputStatus : picosat_solver -> unit = "picosat_OutputStatus"

external picosat_VerifySolution : picosat_solver -> unit = "picosat_VerifySolution"
*)


(*
let picosat_GetVarAssign  (mysolver: picosat_solver) =
  let sz = picosat_NumVariables (mysolver) in
  let varArray = Array.make (sz+1) 0 in
  let get_var_val idx = picosat_GetVarAsgnment (mysolver) idx in
    for i = 1 to sz do
      match get_var_val (i) with
	  -1 -> varArray.(i) <- i
	| 0  -> varArray.(i) <- (-i)
	| 1  -> varArray.(i) <- i
        | _  -> varArray.(i) <- -1
    done;
    varArray
*)



(*********** The following are functions for zcore ***********)

(*

external zcore_InitDatabase : unit -> zcore_database = "zcore_InitDatabase"

external zcore_ReleaseDatabase : zcore_database -> unit = "zcore_ReleaseDatabase"

external zcore_ReadCnf : zcore_database -> string -> unit = "zcore_ReadCnf"

external zcore_ProduceCore : zcore_database -> string -> string -> unit = "zcore_ProduceCore"

external zcore_ProduceCore2 : string -> string -> string -> int -> unit = "zcore_ProduceCore2"
*)



(* The following are functions for circuits convertion 
external picosat_GenClsAnd2 : picosat_solver -> int -> int -> int -> int -> unit = "picosat_GenClsAnd2"

external picosat_GenClsAndN : picosat_solver -> int array -> int -> int -> int -> unit = "picosat_GenClsAndN"
 
*)


(*

void picosat_GenClsOr2	(value mng, 
			 value a,
			 value b,
			 value o, 
			 value gid )
{
  SAT_GenClsOr2( value_to_ptr(mng), Int_val(a), Int_val(b), 
		 Int_val(o), Int_val(gid) );
}

void picosat_GenClsOrN	(value mng, 
			 value inputs,
			 value num_inputs,
			 value o, 
			 value gid )
{

}

void picosat_GenClsNand2	(value mng, 
			 value a,
			 value b,
			 value o,
			 value gid )
{

}

void picosat_GenClsNandN	(value mng, 
			 value inputs,
			 value num_inputs,
			 value o,
			 value gid )
{

}

void picosat_GenClsNor2	(value mng, 
			 value a,
			 value b,
			 value o, 
			 value gid )
{

}

void picosat_GenClsNorN	(value mng, 
			 value inputs,
			 value num_inputs,
			 value o,
			 value gid)
{

}

void picosat_GenClsXor	(value mng, 
			 value a,
			 value b,
			 value o,
			 value gid )
{

}

void picosat_GenClsNot	(value mng, 
			 value a,
			 value o,
			 value gid)
{

}

*)

(*
let picosat = ref (picosat_InitManager ())
let global_clause_gid = ref (-1)
let already_fed_all_clauses = ref false
let time_limit = ref 0.

let feed_picosat_all_clauses _ =
  if !global_clause_gid = -1 then global_clause_gid := picosat_AllocClauseGroupID !picosat;
  if not !already_fed_all_clauses then (picosat_SetNumVariables !picosat !number_variables;
                                        for i = 0 to !number_clauses-1 do
                                          picosat_AddClause !picosat (Array.of_list(!clauses.(i))) !global_clause_gid;
                                        done;
                                        already_fed_all_clauses := true)


let check_for_unsat_val _ =
  feed_picosat_all_clauses ();
  if !time_limit > 0. then picosat_SetTimeLimit !picosat !time_limit;
  let r = picosat_Solve !picosat in
  match r with
        1 -> true
      | _ -> false *)
(*      | _ -> failwith "SAT solver reports neither satisfiable nor unsatisfiable" *)

(*
let picosat_set_time_limit f = (time_limit := f)

*)
