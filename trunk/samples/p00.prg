/*
 * Proyecto: PruebaMVC
 * Fichero: P00.prg
 * Descripción: Ejemplo modo texto de las clases.
 * Autor: Jose Alfonso Suarez Moreno
 *        Manu Exposito Suárez
 * Fecha: 24/08/2011
 * Version: 0.09
 */

/*

//-----------------------------------------------------------------------------
// VERSION JAVA:
//-----------------------------------------------------------------------------

package kk;

import java.util.ArrayList;
import java.util.ListIterator;

public class kk {
  public static void main(String args[]) {
    ArrayList<String> al = new ArrayList<String>();
    ListIterator<String> litr;
    ArrayList<String> a = new ArrayList<String>( 5 );

    a.add("1");
    a.add("2");
    a.add("3");
    a.add("4");
    a.add("5");

    System.out.println("Initial size of al: " + al.size());

    al.add("A");
    al.add("B");
    al.add("C");
    al.add("D");
    al.add("E");
    al.add("F");

    System.out.println("Size of al after additions: " + al.size());

    System.out.println("Contents of al: " + al);

    // Los indices de Java estan basados en 0 en clipper en 1 por eso resto 1
    al.remove(5 - 1 );
    al.remove(2 - 1 );

    System.out.println("Size of al after deletions: " + al.size());
    System.out.println("Contents of al: " + al);

    al.addAll( a );

    System.out.println("Size of al after adictions: " + al.size());
    System.out.println("Contents of al: " + al);

    System.out.println("Index of " + al.get(2-1).toString() + " is " + al.indexOf(al.get(2-1)) + " en cliper seria 1 mas");

    litr = al.listIterator();

    while (litr.hasNext()) {
        System.out.println(litr.next() + "     " + litr.nextIndex());
    }

    // Now, display the list backwards.
    System.out.println("list backwards: ");
    while (litr.hasPrevious()) {
        System.out.println(litr.previous() + "     " + litr.previousIndex());
    }
  }
}

*/

//-----------------------------------------------------------------------------
// VERSION XBASE POO
//-----------------------------------------------------------------------------

#include "hbclass.ch"
REQUEST HB_GT_WIN

//-----------------------------------------------------------------------------
// Programa principal de la prueba

function main()
    local kk := kk()
    kk:run()
return nil

//-----------------------------------------------------------------------------
// Clase principal para el ejemplo de pruebas con ArrayList etc

CLASS kk
    METHOD run()
ENDCLASS

//-----------------------------------------------------------------------------

METHOD run() CLASS kk

    local al := ArrayList():new()
    local a := ArrayList():new()
    local litr

    a:add( String():new("1") )
    a:add( String():new("2") )
    a:add( String():new("3") )
    a:add( String():new("4") )
    a:add( String():new("5") )

    cls

    ? "Initial size of al: " + AllTrim( str( al:size() ) )

    al:add( String():new("A") )
    al:add( String():new("B") )
    al:add( String():new("C") )
    al:add( String():new("D") )
    al:add( String():new("E") )
    al:add( String():new("F") )

    ? "Size of al after additions: " + AllTrim( str( al:size() ) )

    ? "Contents of al: " + al:toString()

    al:remove(5)
    al:remove(2)

    al:set( date(), String():new("X") )

    ? "Size of al after deletions: " + AllTrim( str( al:size() ) )
    ? "Contents of al: " + al:toString()

    al:addAll( a )

    ? "Size of al after adictions: " + AllTrim( str( al:size() ) )
    ? "Contents of al: " + al:toString()

    ? "Index of " + al:get( 2 ):toString() + " is " + str( al:indexOf( al:get( 2 ) ) )

    litr := al:listIterator()

    while litr:hasNext()
        ? litr:next():toString(), litr:nextIndex()
    end
    ?
    ? "list backwards: "
    ?
    while litr:hasPrevious()
        ? litr:previous():toString(), litr:previousIndex()
    end
    ?
    ?
    inKey( 100 )

return nil

//-----------------------------------------------------------------------------
// Clase adicional para las pruebas

#include "EmuClases.prg"

//-----------------------------------------------------------------------------

