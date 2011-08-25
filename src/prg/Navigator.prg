/*
 * Proyecto: PruebaMVC
 * Fichero: Navigator.prg
 * Descripción: Navegador estilo xBase
 * Autor: Jose Alfonso Suarez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */

//-----------------------------------------------------------------------------

#include "hbclass.ch"
#include "common.ch"

//-----------------------------------------------------------------------------

CLASS Navigator FROM ListIterator

   PROTECTED:

   DATA lEof
   DATA lBof

   EXPORTED:

   METHOD new()
   METHOD bof()
   METHOD eof()
   METHOD getCurrentItem()
   METHOD go( n )
   METHOD goBottom()
   METHOD goTop()
   METHOD recCount()
   METHOD recNo()
   METHOD skip( n )

END CLASS

//-----------------------------------------------------------------------------
// Constructor

METHOD new( arrayList ) CLASS Navigator

   super:new( arrayList, 1 )

   ::goTop()

RETURN self

//-----------------------------------------------------------------------------
// Estamos al principio?

METHOD bof() CLASS Navigator
RETURN ::lBof

//-----------------------------------------------------------------------------
// Estamos al final?

METHOD eof() CLASS Navigator
RETURN ::lEof

//-----------------------------------------------------------------------------
// Devuelve el actual elemento

METHOD getCurrentItem() CLASS Navigator

   LOCAL current

   IF ::cursor > 0
      current := ::arrayList:get( ::cursor )
      ::lastRet := ::cursor
   END IF

RETURN current

//-----------------------------------------------------------------------------
// Va a un elemento determinado

METHOD go( n ) CLASS Navigator

   IF ValType( n ) == "N" .AND. n > 0
      IF n > ::arrayList:size()
         ::cursor := ::recCount()
         ::lEof := .t.
      ELSE
         ::cursor := n
         :: lEof := .f.
      ENDIF
   ENDIF

RETURN nil

//-----------------------------------------------------------------------------
// Va al final

METHOD goBottom() CLASS Navigator

   ::cursor := ::arrayList:size()
   ::lEof := .t.
   ::lBof := .f.

RETURN nil

//-----------------------------------------------------------------------------
// Va al principio

METHOD goTop() CLASS Navigator

   ::cursor := 1
   ::lBof := .t.
   ::leof := .f.

RETURN nil

//-----------------------------------------------------------------------------
// Devuelve el numero de elementos del ArrayList

METHOD recCount() CLASS Navigator
RETURN ::arrayList:size()

//-----------------------------------------------------------------------------
// Devuelve el numero del actual elemento activo

METHOD recNo() CLASS Navigator
RETURN ::getCursor()

//-----------------------------------------------------------------------------
// Va a un elemento con un salto absoluto y devuelve cuantos ha saltado

METHOD Skip( n ) CLASS Navigator

   LOCAL ret

   DEFAULT n TO 1

   ret := ::cursor + n
   ::lEof := ( ret > ::recCount() )
   ::lBof := ( ret < 1 )
   ret := Min( Max( n, 1 - ::cursor ), ::recCount() - ::cursor )
   ::cursor += ret

RETURN ret

//-----------------------------------------------------------------------------

