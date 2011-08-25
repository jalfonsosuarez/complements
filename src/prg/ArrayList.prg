/*
 * Proyecto: PruebaMVC
 * Fichero: ArrayList.prg
 * Descripción: Clase para manejar listas.
 * Autor: Jose Alfonso Suarez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */

//-----------------------------------------------------------------------------

#include "hbclass.ch"

#ifndef __XHARBOUR__
    #define DEFAULT OTHERWISE
    #define ADel HB_ADel
    #define AIns HB_AIns
#endif

//-----------------------------------------------------------------------------

CLASS ArrayList FROM Object

    PROTECTED:
    DATA items

    EXPORTED:
    METHOD new( xVal ) CONSTRUCTOR
    METHOD add( item )
    METHOD addAll( items )
    METHOD clear()
    METHOD contains( item )
    METHOD ensureCapacity( minCapacity )
    METHOD get( index )
    METHOD indexOf( item )
    METHOD insert( index, item )
    METHOD isEmpty()
    METHOD lastIndexOf( item )
    METHOD listIterator( index )
    METHOD navigator()
    METHOD rangeCheck( index )
    METHOD remove( index )
    METHOD removeObject( obj )
    METHOD removeRange( fromIndex, toIndex )
    METHOD set( index, item )
    METHOD size()
    METHOD toArray()
    METHOD toString()

END CLASS

//-----------------------------------------------------------------------------
// Constructor

METHOD new( xVal ) CLASS ArrayList

    SWITCH Valtype( xVal )
        CASE 'N'
            ::items := Array( if( xVal > 0, xVal, 0 ) )
            EXIT
        CASE 'A'
            ::items := AClone( xVal )
            EXIT
        DEFAULT
            ::items := {}
    END SWITCH

RETURN self

//-----------------------------------------------------------------------------
// Añade un nuevo elemento

METHOD add( item ) CLASS ArrayList

    LOCAL s := ::size()

    AAdd( ::items, item )

RETURN ( s < ::size() )

//-----------------------------------------------------------------------------
// Añade los elementos de un ArrayList o array a la lista

METHOD addAll( items ) CLASS ArrayList

    LOCAL i, l, t, s := ::size()

    SWITCH ValType( items )
        CASE 'A'
            IF ( ( l := Len( items ) ) > 0 )
                t := s + l
                ASize( ::Items, t )
                FOR i := s + 1 TO t
                    ::items[ i ] := items[ i - s ]
                NEXT
            END IF
            EXIT
        CASE 'O'
            IF items:ClassName() == "ARRAYLIST" .AND. ( ( l := items:size() ) > 0 )
                t := s + l
                ASize( ::Items, t )
                FOR i := s + 1 TO t
                    ::items[ i ] := items:items[ i - s ]
                NEXT
            END IF
            EXIT
        DEFAULT
            // De momento no se hace nada
    END SWITCH

RETURN ( s < ::size() )

//-----------------------------------------------------------------------------
// Elimina todos los elementos

METHOD clear() CLASS ArrayList

    ::items := {}

RETURN nil

//-----------------------------------------------------------------------------
// Comprueba si existe el item en la lista

METHOD contains( item ) CLASS ArrayList
RETURN ( ::indexOf( item ) > 0 )

//-----------------------------------------------------------------------------
// Incrementa el tamaño si es necesario

METHOD ensureCapacity( minCapacity ) CLASS ArrayList

    IF Hb_IsNumeric( minCapacity ) .AND. minCapacity > ::size()
        ASize( minCapacity )
    ENDIF

RETURN nil

//-----------------------------------------------------------------------------
// Devuelve el item ocupado por el indice especificado

METHOD get( index ) CLASS ArrayList

    LOCAL ret

    IF ::rangeCheck( index )
        ret := ::items[ index ]
    ENDIF

RETURN ret

//-----------------------------------------------------------------------------
// Devuelve la posición del primer elemento que coincida con el buscado

METHOD indexOf( item ) CLASS ArrayList

    LOCAL ret := -1
    LOCAL n, s := ::size()

    IF s > 0 .AND. ValType( item ) != "U"
        FOR n := 1 TO s
            IF item == ::items[ n ]
                ret := n
                EXIT
            ENDIF
        NEXT
    ENDIF

RETURN ret

//-----------------------------------------------------------------------------
// Inserta un elemento en la posiscion indicada, si el tamaño de la lista
// es menor lo aumenta
// Equivale a add( index, object )

METHOD insert( index, item )

    AIns( ::items, index, item, .T. )

RETURN item

//-----------------------------------------------------------------------------
// Comprueba si hay elementos en la lista

METHOD isEmpty() CLASS ArrayList
RETURN ( ::size() == 0 )

//-----------------------------------------------------------------------------
// Devuelve el ultimo item igual al item pasado en la lista

METHOD lastIndexOf( item )

    LOCAL ret := -1
    LOCAL n, s := ::size()

    IF s > 0 .AND. ValType( item ) != "U"
        FOR n := s TO 1 STEP -1
            IF item == ::items[ n ]
                ret := n
                EXIT
            ENDIF
        NEXT
    ENDIF

RETURN ret

//-----------------------------------------------------------------------------
// Devuelve un item iterator para la lista

METHOD listIterator( index ) CLASS ArrayList
RETURN ListIterator():New( self, index )

//-----------------------------------------------------------------------------
// Devuelve un item navigator para la lista

METHOD navigator() CLASS ArrayList
RETURN Navigator():New( self )

//-----------------------------------------------------------------------------
// Comprueba que el indice dado este dentro del rango del ArrayList

METHOD rangeCheck( index ) CLASS ArrayList
RETURN( Hb_IsNumeric( index ) .AND. index > 0 .AND. index <= ::size() )

//-----------------------------------------------------------------------------
// Elimina un item de la lista por el orden, redimensiona el array

METHOD remove( index ) CLASS ArrayList

    LOCAL ret

    IF ::rangeCheck( index )
        ret := ::items[ index ]
        ADel( ::items, index, .t. )
    ENDIF

RETURN ret

//-----------------------------------------------------------------------------
// Elimina un item de la lista, redimensiona el array
// Equivale a remove( object ) de java

METHOD removeObject( obj ) CLASS ArrayList
RETURN(  ::remove( ::indexOf( obj ) ) != nil )

//-----------------------------------------------------------------------------
// Elimina un rango de elementos de la lista

METHOD removeRange( fromIndex, toIndex ) CLASS ArrayList

    LOCAL n, i, a, s

    IF ::rangeCheck( fromIndex ) .AND. ::rangeCheck( toIndex )
        IF fromIndex == toIndex
            ADel( ::items, toIndex, .t. )
        ELSEIF fromIndex < toIndex
            n := 0
            s := ::size()
            a := Array( s - ( 1 + toIndex - fromIndex ) )
            FOR i := 1 TO s
                IF i < fromIndex .OR. i > toIndex
                    a[ ++n ] := ::items[ i ]
                END IF
            NEXT
            ::items := a
            a := nil
        END IF
    END IF

RETURN nil

//-----------------------------------------------------------------------------
// Reemplaza el item que ocupa la posicion indicada

METHOD set( index, item ) CLASS ArrayList

    LOCAL itemOld

    IF ::rangeCheck( index )
        itemOld := ::items[ index ]
        ::items[ index ] := item
    ENDIF

RETURN itemOld

//-----------------------------------------------------------------------------
// Devuelve el tamaño de la lista

METHOD size() CLASS ArrayList
RETURN Len( ::items )

//-----------------------------------------------------------------------------
// Devueleve un array con los elementos del Collection

METHOD toArray() CLASS ArrayList

    LOCAL array
    LOCAL i, s := ::size()

    IF s > 0
        array := Array( s )
        FOR i := 1 TO s
            array[ i ] := ::items[ i ]:toArray()
        NEXT
    ELSE
        array := {}
    END IF

RETURN array

//-----------------------------------------------------------------------------
// Devueleve una cadena con los elementos del Collection

METHOD toString() CLASS ArrayList

   LOCAL i, s := ::size()
   LOCAL string

    IF s > 0
        string := "["
        --s
        FOR i := 1 TO s
            string += ::items[ i ]:toString() + ", "
        NEXT
        string += ::items[ i ]:toString() + "]"
    ELSE
        string := "[]"
    END IF

RETURN string

//-----------------------------------------------------------------------------

