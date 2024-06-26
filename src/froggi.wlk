import wollok.game.*
import obstaculos.*
import consumibles.*
import ui.*
import randomizer.*
import config.*

class Froggi {

	const cordDelAgua = 6
    var property position = game.at(9 , 0)
    var property estado = vivo // Borramos o dejamos los estados? (ya no se usan, solo para la img)
    var property vida = 5

    var property puntos = 0
	var cantidadDeVecesGanadas = 0
	var property movimiento = new Libre(position = game.at(9, 0))

	method position(_position) {
		movimiento.position(_position)
	}

	method position() {
		return movimiento.position()
	}

	method image() {
		return "froggi-" + estado.image() + ".png"
	}

	method cantidadDeVecesGanadas() {
		return cantidadDeVecesGanadas
	}

	method quitarVida(cantidad) {
		vida -= cantidad
			// console.println(self.vida()) // DESPUES BORRAR, SOLO DE PRUEBA
		self.estoyMuerto()
	}

	method agregarVida(cantidad) {
		vida += cantidad
	}

	method agregarPuntos(cantidad) {
		puntos += cantidad
	}

	method quitarPuntos(cantidad){
        puntos -= cantidad
    }

	method estoyMuerto() {
		if (self.vida() <= 0) {
			configuracionJuego.terminarJuego(pantallaMuerte)
		}
	}

	method aumentarVecesGanadas() {
		cantidadDeVecesGanadas += 1
	}

	method moverArriba() {
		self.position(self.position().up(1))
		self.estoySobreElAgua()
	}

	method moverAbajo() {
		self.position(self.position().down(1))
		self.estoySobreElAgua()
	}

	method moverIzquierda() {
		self.position(self.position().left(1))
		self.estoySobreElAgua()
	}

	method moverDerecha() {
		self.position(self.position().right(1))
		self.estoySobreElAgua()
	}
	
	method estoySobreElAgua(){
		if(game.colliders(self).isEmpty() and self.position().y() > cordDelAgua ){ // poner parametro con el 6
			self.quitarVida(1)
			self.position(game.at(9 , 0))
		}
	}


}

class SobreTronco {

	var property transporte
	var property personaje

	method position() {
		return transporte.position()
	}

	method position(_position) {
		personaje.movimiento(new Libre(position = _position))
	}
	
	method estoySobreTronco(){
		return true
	}

}

class Libre {

	var property position
	
	method estoySobreTronco(){
		return false
	}

}

object vivo {

	method image() {
		return "vivo"
	}

}

object muerto {

	method image() {
		return "muerto"
	}

}