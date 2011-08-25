/*
 * Proyecto: PruebaMVC
 * Fichero: ListIterator.prg
 * Descripción: Iterador para recorrer listas.
 * Autor: José Alfonso Suárez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */

//-----------------------------------------------------------------------------

#include "hbclass.ch"

//-----------------------------------------------------------------------------

CLASS ListIterator FROM Object

    PROTECTED:

    DATA lastRet
    DATA cursor
    DATA arrayList

    EXPORTED:

    METHOD new( arrayList ) CONSTRUCTOR
    METHOD add( objeto )
    METHOD hasNext()
    METHOD hasPrevious()
    METHOD next()
    METHOD nextIndex()
    METHOD previous()
    METHOD previousIndex()
    METHOD remove()
    METHOD set( objeto )

    // Set - Get
    METHOD getCursor()
    METHOD setCursor( i )
    METHOD getarrayList()
    METHOD getLastRet()

END CLASS

//-----------------------------------------------------------------------------
// Constructor

METHOD new( arrayList, i ) CLASS ListIterator

    ::arrayList := arrayList
    ::lastRet := 0
    ::cursor := if( ::arrayList:RangeCheck( i ), i, 1 )

RETURN self

//-----------------------------------------------------------------------------
// Añade un elemento nuevo a la lista tratada

METHOD add( objeto ) CLASS ListIterator

    ::arrayList:add( objeto )
    ::cursor := ::arrayList:size()
    ::lastRet := 0

RETURN nil

//-----------------------------------------------------------------------------
// Devuelve true si  la lista tiene más elementos en la dirección de avance

METHOD hasNext() CLASS ListIterator
RETURN !( ::cursor > ::arrayList:size() )

//-----------------------------------------------------------------------------
// Devuelve un valor logico dependiendo si hay elementos por detras

METHOD hasPrevious() CLASS ListIterator
RETURN ::cursor != 1

//-----------------------------------------------------------------------------
// Devuelve el elemento actual de la lista y avanza

METHOD next() CLASS ListIterator

    LOCAL next := ::arrayList:get( ::cursor )

    IF next != nil
        ::lastRet := ::cursor++
    END IF

RETURN next

//-----------------------------------------------------------------------------
// Devuelve el indice del siguiente elemento

METHOD nextIndex() CLASS ListIterator
RETURN ::cursor

//-----------------------------------------------------------------------------
// Devuelve el elemento actual de la lista y retrocede

METHOD previous() CLASS ListIterator

    LOCAL i := ::cursor - 1
    LOCAL previous := ::arrayList:get( i )

    IF previous != nil
        ::lastRet := ::cursor := i
    END IF

RETURN previous

//-----------------------------------------------------------------------------
// Devuelve el indice del elemnto anterior

METHOD previousIndex() CLASS ListIterator
RETURN ::cursor - 1

//-----------------------------------------------------------------------------
// Borra el ultimo elemento devuelto

METHOD remove() CLASS ListIterator

    IF ::lastRet > 0
        ::arrayList:remove( ::lastRet )
        IF :: lastRet > ::cursor
            ::cursor--
        END IF
        ::lastRet := 0
    END IF

RETURN nil

//-----------------------------------------------------------------------------
// Sustituye el ultimo elemento devuelto

METHOD set( objeto ) CLASS ListIterator

    IF ::lastRet > 0
        ::arrayList:set( ::lastRet, objeto )
    END IF

RETURN nil

//-----------------------------------------------------------------------------
// Obtiene la actual posicion del cursor

METHOD getCursor() CLASS ListIterator
RETURN ::cursor

//-----------------------------------------------------------------------------
// Actualiza la posicion del cursor

METHOD setCursor( i ) CLASS ListIterator

    LOCAL ret := ::cursor

    IF ::arrayList:RangeCheck( i )
        ::cursor := i
    END IF

RETURN ret

//-----------------------------------------------------------------------------
// Obtiene el objeto ArrayList

METHOD getArrayList() CLASS ListIterator
RETURN ::arrayList

//-----------------------------------------------------------------------------
// Obtiene el objeto devuelto

METHOD getLastRet() CLASS ListIterator
RETURN ::lastRet

//-----------------------------------------------------------------------------

