
/**
 *  This is a wrapper for picosat solver
 *
 */

extern "C"{
#include "picosat.h"
}
#include "picosat_ocaml_wrapper.h"

#include <sys/types.h>
#include <dirent.h>
#include <iostream>
#include <fstream>
#include <streambuf>
#include <cassert>


using namespace std;

//void my_read_cnf(PicoSAT * mng, char * filename );
//void my_handle_result(PicoSAT * mng, int outcome, char * filename );
//void my_output_status(PicoSAT * mng);
//void my_verify_solution(PicoSAT * mng);


#ifdef __cplusplus
extern "C" {
#endif

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/custom.h>

#ifdef __cplusplus
}
#endif

//static const int MAX_LINE_LENGTH       = 65536;
//static const int MAX_WORD_LENGTH       = 64;



extern "C" value picosat_InitManager(void)
{
  CAMLparam0 ();
  PicoSAT * temp = picosat_init();
  CAMLreturn( (value)temp ); 
}


extern "C" value picosat_ReleaseManager(value mng)
{
  CAMLparam1( mng );
  PicoSAT * solver = (PicoSAT *)mng;
  picosat_reset(solver);

  CAMLreturn(Val_unit);
}

extern "C" value picosat_SetNumVariables(value mng, value num_vars)
{
  CAMLparam2 ( mng, num_vars );
  PicoSAT * solver = (PicoSAT *)mng;
  picosat_adjust( solver, Int_val(num_vars));
  CAMLreturn ( Val_unit );
}

extern "C" value picosat_AddVariable(value mng)
{
  CAMLparam1( mng );

  PicoSAT * solver = (PicoSAT *)mng;
  assert(solver != NULL);
  int retval = picosat_inc_max_var(solver);

  CAMLreturn ( Val_int(retval) );
}


extern "C" value picosat_AddClause(value mng, value clause_lits, value gid)
{
  CAMLparam3 ( mng, clause_lits, gid );
  PicoSAT * solver = (PicoSAT *)mng;
  int context = picosat_context(solver);
  int id = (int)gid;

  int size = Wosize_val(clause_lits);
  
  if(size > 0){
    if( id != 0 && context == 0 ){
      context = picosat_push(solver);
      int max = picosat_inc_max_var(solver); 
    }
  }
  

  int * arr = new int[size + 1];
  int i , temp ;

  for (i = 0; i < size; i++)
    {

      temp = Int_val( Field(clause_lits, i) );
      if (temp > 0){ 
	arr[i] = temp;

	}
      else{
	arr[i] = temp *(-1);

      }
      //    printf("arr[%d]=%d\n", i, arr[i]);
    }

  arr[size] = 0;
  
  
  picosat_add_lits( solver, arr );
  CAMLreturn ( Val_unit );
}


extern "C" value picosat_DeleteClauseGroup(value mng, value gid)
{
  CAMLparam2 ( mng, gid );
  picosat_pop( (PicoSAT *)mng );
  CAMLreturn ( Val_unit );
}


extern "C" value  picosat_Reset(value mng)
{
  CAMLparam1 ( mng );
  PicoSAT * solver = (PicoSAT*) mng;
  picosat_reset_phases(solver);
  picosat_reset_scores(solver);
  picosat_remove_learned(solver, 100);
  CAMLreturn ( Val_unit );
}


extern "C" value picosat_AllocClauseGroupID(value mng)
{
  CAMLparam1 ( mng );
  int retval = picosat_context( (PicoSAT *)mng );

  CAMLreturn( Val_int( retval ) );
}



extern "C" value picosat_SetTimeLimit(value mng, value runtime)
{
  CAMLparam2 ( mng , runtime );
  PicoSAT * solver = (PicoSAT*)mng;
  CAMLreturn ( Val_unit );
}



extern "C" value picosat_Solve( value mng)
{
  cout.setstate(std::ios_base::badbit);

  CAMLparam1 ( mng );
  int retval = picosat_sat( (PicoSAT *) mng, -1 );
  printf("Satisfiable? %d \n", retval);
  if (retval == 10){
    retval = 2;
  }
  else if (retval == 20){
    retval = 1;
  }
  CAMLreturn ( Val_int(retval) );
}

extern "C" value picosat_GetVarAsgnment(value mng, value v_idx)
{
  CAMLparam2 ( mng, v_idx );
  int retval = picosat_deref( (PicoSAT *)mng, Int_val(v_idx) );
  CAMLreturn( Val_int(retval) );
}


extern "C" value picosat_NumLiterals(value mng)
{
  CAMLparam1 ( mng );
  PicoSAT * solver = (PicoSAT*)mng;
  int retval = picosat_lits(solver);
  CAMLreturn ( Val_int(retval) );
}

extern "C" value picosat_NumClauses(value mng)
{
  CAMLparam1 ( mng );
  PicoSAT * solver = (PicoSAT*)mng;
  int retval = picosat_added_original_clauses(solver);
  CAMLreturn ( Val_int(retval) );
}

extern "C" value picosat_NumVariables(value mng)
{
  CAMLparam1 ( mng );
  int retval = picosat_variables( (PicoSAT *)mng );
  CAMLreturn ( Val_int(retval) );
}

