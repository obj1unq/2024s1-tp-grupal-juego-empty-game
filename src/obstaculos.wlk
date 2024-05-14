import wollok.game.*

class Obstaculo {

	var property position = null
	var property nombreDeObstaculo // TIPO: String
	var property cantidadDeDanio
	var property velocidad

	method colision(objeto) {
		objeto.quitarVida(cantidadDeDanio) // Polimorfismo con froggi, es necesario crearlo en froggi
	}

	method image() {
//		return self.cambiarTipo(nombreDeObstaculo)  //No funciona como se espera
		return nombreDeObstaculo + ".png"
	}

	method mover() {
		if (self.estoyEnElBordeDelTablero(game.at(0, position.y()))) { // El parametro signfica borde izquierdo
			return game.onTick(velocidad, "avanzar", { self.position(position.right(1)) })
		} else {
			return game.onTick(velocidad, "avanzar", { self.position(position.left(1)) })
		}
	}

	method cambiarTipo(stringObstaculo) {
		return stringObstaculo + 1.randomUpTo(3).roundUp().toString() + ".png"
	}

	method estoyEnElBordeDelTablero(borde) {
		return self.position().distance(borde) == 0
	}

}

object spawnerDeObstaculos {

	method inicializarObstaculoEnPosicion(obstaculo, position) {
		obstaculo.position(position)
		game.addVisual(obstaculo)
		obstaculo.mover()
	}
	
	method poolDeVehiculos(cantidad, posicion){
		
	}
	
	method positionDentroDeCalle() {
		if (0.randomUpTo(10) > 5) {
			return game.at(game.width() - 1, self.rangoDeAlto())
		} else {
			return game.at(0, self.rangoDeAlto())
		}
	}
	
	method rangoDeAlto(){
		return 0.randomUpTo(5).roundUp()
	}

}

