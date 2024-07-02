import aliens.*
import nave.*
import wollok.game.*
import barrera.*
import balas.*
import score.*

object _ {

	method generar(posicion) {
	}

}

class GeneradorAlien {

	method generar(posicion) {
		const alien = self.alienNuevo(posicion)
		alien.nacer()
	}

	method alienNuevo(posicion)

}

object r inherits GeneradorAlien {

	override method alienNuevo(posicion) {
		return new AlienRojo(position = posicion)
	}

}

object a inherits GeneradorAlien {

	override method alienNuevo(posicion) {
		return new AlienAmarillo(position = posicion)
	}

}

object v inherits GeneradorAlien {

	override method alienNuevo(posicion) {
		return new AlienVerde(position = posicion)
	}

}

object n {

	method generar(posicion) {
		nave.position(posicion)
		game.addVisualCharacter(nave)
	}

}

object c {

	method generar(posicion) {
		const corazon = self.corazonNuevo(posicion)
		corazon.nacer()
	}

	method corazonNuevo(posicion) {
		return new Corazon(position = posicion)
	}

}

//////////////////////////////////////////////////////////////////////////////////////
class GeneradorBarrera {

	method generar(posicion) {
		const barrera = self.barreraNueva(posicion)
		barrera.nacer()
	}

	method barreraNueva(posicion)

}

object g inherits GeneradorBarrera {

	override method barreraNueva(posicion) {
		return new BarreraGris(position = posicion)
	}

}

object m inherits GeneradorBarrera {

	override method barreraNueva(posicion) {
		return new BarreraMarron(position = posicion)
	}

}




object e {
	var property position 
	method generar(posicion) {
		const escore = self.nuevoScore(posicion)
		escore.nacer()
	}
	method nuevoScore(posicion) {
		return new Score(position = posicion)
	}
	
	
	
}


object q {
	method generar(posicion) {
		const digQ = self.nuevoDigito(posicion)
		digQ.nacer()
		
	}
	method nuevoDigito(posicion) {
		return new CuartoD(position = posicion)
	}
	
}

object o {
	method generar(posicion) {
		const digO = self.nuevoDigito(posicion)
		digO.nacer()
	}
	method nuevoDigito(posicion) {
		return new PrimerD(position = posicion)
	}
}

object w {
	method generar(posicion) {
		const digW = self.nuevoDigito(posicion)
		digW.nacer()
		
	}
	method nuevoDigito(posicion) {
		return new SegundoD(position = posicion)
	}

}


object t {
	method generar(posicion) {
		const digT = self.nuevoDigito(posicion)
		digT.nacer()
	}
	method nuevoDigito(posicion) {
		return new TercerD(position = posicion)
	}
}








object mapa {

	const celdas = [
		[c,c,c,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,e,_,q,t,w,o], // 15
		[_,_,_,_,_,_,_,_,r,r,r,r,r,r,r,r,_,_,_,_,_,_,_,_], // 14
		[_,_,_,_,_,_,_,_,v,v,v,v,v,v,v,v,_,_,_,_,_,_,_,_], // 13
		[_,_,_,_,_,_,_,_,v,v,v,v,v,v,v,v,_,_,_,_,_,_,_,_], // 12
		[_,_,_,_,_,_,_,_,a,a,a,a,a,a,a,a,_,_,_,_,_,_,_,_], // 11
		[_,_,_,_,_,_,_,_,a,a,a,a,a,a,a,a,_,_,_,_,_,_,_,_], // 10
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 9
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 8
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 7
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 6
		[_,_,_,g,_,_,_,_,m,_,_,_,m,_,_,g,_,_,_,_,g,_,_,_], // 5
		[_,_,_,_,_,_,g,_,_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,_], // 4
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 3
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 2
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_], // 1
		[_,_,_,_,_,_,_,_,_,_,_,n,_,_,_,_,_,_,_,_,_,_,_,_] // 0
	].reverse()
	

	method generar() {
		(0 .. game.width() - 1).forEach({ x => (0 .. game.height() - 1).forEach({ y => self.generarCelda(x, y)})})
		flota.spawn()
	}

	method generarCelda(x, y) {
		const celda = celdas.get(y).get(x)
		celda.generar(game.at(x, y))
	}

}

