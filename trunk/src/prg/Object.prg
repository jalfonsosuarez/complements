/*
 * Proyecto: PruebaMVC
 * Fichero: Object.prg
 * Descripción: Clase madre de todas.
 * Autor: Jose Alfonso Suarez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */

//-----------------------------------------------------------------------------

#include "hbclass.ch"

//-----------------------------------------------------------------------------

CLASS Object

    EXPORTED:

    METHOD new() CONSTRUCTOR
    METHOD clone()
    METHOD equals( obj )
    METHOD toString()

ENDCLASS

//-----------------------------------------------------------------------------
// Constructor

METHOD new() CLASS Object
RETURN Self

//-----------------------------------------------------------------------------
// Devuelve un clon del actual objeto

METHOD clone() CLASS Object
RETURN __objClone( Self )

//-----------------------------------------------------------------------------
// Devuelve un clon del actual objeto

METHOD equals( obj ) CLASS Object
RETURN ( Self == obj )

//-----------------------------------------------------------------------------
// Devuelve una representacion del objeto

METHOD toString() CLASS Object
RETURN ::className() + "@" + AllTrim( Str( ::classH() ) )

//-----------------------------------------------------------------------------

